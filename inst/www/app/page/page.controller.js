/**
 * Angular JS App - OpenCPUDemo
 *
 * Controller - Partial pages
 *
 */

/**
 * Page - Home
 */
opencpuDemoApp.controller('pageHomeController', ['$scope', 'opencpuGateService', function($scope, opencpuGateService){

    $scope.ocpuGate = opencpuGateService;

      /**
     * Function - Run basic descriptive
     */
    $scope.runDescriptive = function() {
        // Prep the params
        var funcName = 'run_descriptive';
        var params = {};

        //
        $scope.ocpuGate.ocpuCall(funcName, params)
            .then(
                /** Successful */
                function(data){
                    console.log(data);
                    $scope.ocpuGate.updated = true;
                }
            );

    };

}]);

opencpuDemoApp.controller('pageKmController', ['$scope', 'opencpuGateService', function($scope, opencpuGateService){

    $scope.ocpuGate = opencpuGateService;

    /**
     * Function - Run basic descriptive
     */
    $scope.km = function() {
        // Prep the params
        var funcName = 'km';
        var params = {};

        //
        $scope.ocpuGate.ocpuCall(funcName, params)
            .then(
            /** Successful */
            function(data){
                console.log(data);
                $scope.ocpuGate.updated = true;
            }
        );

    };

}]);

opencpuDemoApp.controller('pageCoxController', ['$scope', 'opencpuGateService', function($scope, opencpuGateService){

    $scope.ocpuGate = opencpuGateService;

    /**
     * Function - Run basic descriptive
     */
    $scope.cox = function() {
        // Prep the params
        var funcName = 'cox';
        var params = {};

        //
        $scope.ocpuGate.ocpuCall(funcName, params)
            .then(
            /** Successful */
            function(data){
                console.log(data);
                $scope.ocpuGate.updated = true;
            }
        );

    };

}]);

opencpuDemoApp.controller('pagePoController', ['$scope', 'opencpuGateService', function($scope, opencpuGateService){

    $scope.ocpuGate = opencpuGateService;

    /**
     * Function - Run basic descriptive
     */
    $scope.po = function() {
        // Prep the params
        var funcName = 'po';
        var params = {};

        //
        $scope.ocpuGate.ocpuCall(funcName, params)
            .then(
            /** Successful */
            function(data){
                console.log(data);
                $scope.ocpuGate.updated = true;
            }
        );

    };

}]);

opencpuDemoApp.controller('pagePhphController', ['$scope', 'opencpuGateService', function($scope, opencpuGateService){
    $scope.ocpuGate = opencpuGateService;

    /**
     * Function - Run basic descriptive
     */
    $scope.phph = function() {
        // Prep the params
        var funcName = 'phph';
        var params = {};

        //
        $scope.ocpuGate.ocpuCall(funcName, params)
            .then(
            /** Successful */
            function(data){
                console.log(data);
                $scope.ocpuGate.updated = true;
            }
        );

    };
}]);

opencpuDemoApp.controller('pageTestController', ['$scope', 'opencpuGateService', function($scope, opencpuGateService){
    $scope.ocpuGate = opencpuGateService;

    /**
     * Function - Run basic descriptive
     */
    $scope.runDescriptive2 = function() {
        // Prep the params
        var funcName = 'run_descriptive2';
        var params = {};

        //
        $scope.ocpuGate.ocpuCall(funcName, params)
            .then(
            /** Successful */
            function(data){
                console.log(data);
                $scope.ocpuGate.updated = true;
            }
        );

    };
}]);
