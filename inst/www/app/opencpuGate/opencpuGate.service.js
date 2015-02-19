/**
 * Angular JS Module - OpenCPU Gate
 *
 * Service
 *
 */


opencpuGateModule.factory('opencpuGateCachingService', ['$cacheFactory', function($cacheFactory){

    return $cacheFactory('opencpuGateCachingService');
}]);

opencpuGateModule.factory('opencpuGateService', ['$q', 'md5', 'opencpuGateCachingService', function($q, md5, opencpuGateCachingService){

    //  Create a class that represents our name service.
    function opencpuGateService() {

        // Self handler
        var self = this;

        // Factory cache
        self.cache = opencpuGateCachingService;
        self.cacheKey = '';

        // Watcher
        self.updated = false;

        self.resultMatrix = {
            useTab: false
        };

        // Properties
        self.successfulPackage = {
            success: false,
            errorMsg: '',
            tableArray: [],
            plotArray: [],
            printArray: [],
            statusArray: [],
            sessionKey: '',
            sessionLocation: '',
            outputString: ''
        };

        self.failedPavkage = {
            success: false,
            errorMsg: ''
        };

        // OpenCPU Call Functions
        self.ocpuCall = function(funcName, params) {

            //  Create a deferred operation.
            var deferred = $q.defer();

            // Check if it can be found from the cache
            self.cacheKey = md5.createHash(funcName + JSON.stringify(params));
            //console.log('Cache-Key ' + self.cacheKey);
            //console.log(self.cache.info());
            var package = self.cache.get(self.cacheKey);
            if(package !== undefined) {

                //console.log("Cache found!! - " + self.cacheKey);
                //console.log(package);
                // Solve the deferred object, and return the cached package
                self.successfulPackage = angular.fromJson(package);
                //console.log(self.successfulPackage);
                deferred.resolve(self.successfulPackage);

                return deferred.promise;
            }

            var req = ocpu.call(funcName, params, function(session){

                // Get the session key
                self.successfulPackage.sessionKey = session.getKey();
                self.successfulPackage.sessionLocation = session.getLoc();

                // Get the data
                // The data returned from the backend R is in the format of JSON.
                session.getObject(function(dataJSON){

                    //console.log(dataJSON);

                    self.successfulPackage.statusArray = dataJSON.status;
                    var status = dataJSON.status[0].msg;
                    if(status == "fail") {
                        this.failedPavkage.errorMsg = dataJSON.status[0].reason;

                        // Reject the deferred object
                        deferred.reject(self.failedPavkage);
                    }

                    // Successful
                    self.successfulPackage.success = true;

                    self.successfulPackage.tableArray = dataJSON.tables;
                    self.successfulPackage.plotArray = dataJSON.plots;
                    self.successfulPackage.printArray = dataJSON.prints;

                    // Get Stdout
                    session.getStdout(function(stdout){
                        self.successfulPackage.outputString = stdout;

                        // Save the cache
                        //console.log('Save Cache:' + self.cacheKey);
                        //console.log(self.successfulPackage);
                        self.cache.put(self.cacheKey, angular.toJson(self.successfulPackage));
                        //console.log(self.successfulPackage.sessionKey);
                        //self.cache.put(self.cacheKey, self.successfulPackage.sessionKey);

                        // Solve the deferred object
                        deferred.resolve(self.successfulPackage);
                    });

                });

            });

            return deferred.promise;
        };

        // Data Manipulation Utilities

        /**
         * Prepare the results matrix from the original JSON structure.
         *
         * The results matrix will be used to display in HTML DOM.
         * Several conditions:
         *  - Single Page: no need to use "Nav Tab"
         *  - Multiple Pages: Need to use "Nav Tab"
         *
         *  The general structure is like:
         *  {
         *      useTab: true,
         *      tabs: [
         *         {
         *          tabName: "Tab 1",
         *          plot: [
         *          ],
         *          table: [
         *          ],
         *          print: [
         *          ]
         *         },
         *         {
         *          tabName: "Tab 2",
         *          plot: [
         *          ],
         *          table: [
         *          ],
         *          print: [
         *          ]
         *         }
         *      ],
         *      status: [
         *      ]
         *
         *  }
         *
         */
        self.prepResultMatrix = function() {

            var useTab = false;
            var tabArray = [];

            var plotArray = self.successfulPackage.plotArray;
            var tableArray = self.successfulPackage.tableArray;
            var printArray = self.successfulPackage.printArray;

            // Loop into Plots array
            if (plotArray != null && plotArray.length > 0) {

                $.each(plotArray, function(idx, plotObj) {
                    var plotTab = plotObj.tab;

                    tabArray = self.addTabPlotElement(plotTab, plotObj, tabArray);

                });
            }

            // Loop into Tables array
            if (tableArray != null && tableArray.length > 0) {

                $.each(tableArray, function(idx, tableObj) {
                    var tableTab = tableObj.tab;

                    tabArray = self.addTabTableElement(tableTab, tableObj, tabArray);

                });
            }

            // Loop into Prints array
            if (printArray != null && printArray.length > 0) {

                $.each(printArray, function(idx, printObj) {
                    var printTab = printObj.tab;

                    tabArray = self.addTabPrintElement(printTab, printObj, tabArray);

                });
            }

            // Construct the final structure
            if(tabArray.length > 1) {
                useTab = true;
            }
            self.resultMatrix.useTab = useTab;
            self.resultMatrix.tabs = tabArray;
            self.resultMatrix.status = self.successfulPackage.statusArray;
        }


        //


        self.addTabPlotElement = function(tabName, plotObj, tabArray) {
            if(tabName == '' || tabName == null) {
                // Skip
                return tabArray;
            }

            var added = false;

            // Check if the "tab" already exists.
            // If so, insert it. Otherwise, add a new one.
            $.each(tabArray, function(idx, tabObj) {
                if(tabObj.tabName == tabName) {
                    // insert the element obj here
                    if(tabObj.plot == null){
                        tabObj.plot = [];
                    }
                    tabObj.plot.push(plotObj);

                    added = true;
                    return false;
                }
            });

            // Create a new tab obj
            if(!added) {
                var tabObj = {};
                tabObj.tabName = tabName;
                tabObj.plot = [];
                tabObj.plot.push(plotObj);
                tabArray.push(tabObj);
            }

            return tabArray;
        }

        self.addTabTableElement = function(tabName, tableObj, tabArray) {
            if(tabName == '' || tabName == null) {
                // Skip
                return tabArray;
            }

            var added = false;

            // Check if the "tab" already exists.
            // If so, insert it. Otherwise, add a new one.
            $.each(tabArray, function(idx, tabObj) {
                if(tabObj.tabName == tabName) {
                    // insert the element obj here
                    if(tabObj.table == null){
                        tabObj.table = [];
                    }
                    tabObj.table.push(tableObj);

                    added = true;
                    return false;
                }
            });

            // Create a new tab obj if needed
            if(!added) {
                var tabObj = {};
                tabObj.tabName = tabName;
                tabObj.table = [];
                tabObj.table.push(tableObj);
                tabArray.push(tabObj);
            }

            return tabArray;
        }

        self.addTabPrintElement = function(tabName, printObj, tabArray) {
            if(tabName == '' || tabName == null) {
                // Skip
                return tabArray;
            }

            var added = false;

            // Check if the "tab" already exists.
            // If so, insert it. Otherwise, add a new one.
            $.each(tabArray, function(idx, tabObj) {
                if(tabObj.tabName == tabName) {
                    // insert the element obj here
                    if(tabObj.print == null){
                        tabObj.print = [];
                    }
                    tabObj.print.push(printObj);

                    added = true;
                    return false;
                }
            });

            // Create a new tab obj if needed
            if(!added) {
                var tabObj = {};
                tabObj.tabName = tabName;
                tabObj.print = [];
                tabObj.print.push(printObj);
                tabArray.push(tabObj);
            }

            return tabArray;
        }

    };


    return new opencpuGateService();

}]);