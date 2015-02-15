/**
 * Angular JS Module - OpenCPU Gate
 *
 * Controller - Control results from 'R'
 *
 */

opencpuGateModule.controller('opencpuGateController', ['$scope', 'opencpuGateService', function($scope, opencpuGateService){

    $scope.ocpuGate = opencpuGateService;
    $scope.useTab = false;
    $scope.tabArray = [];
    $scope.firstTabObj = {};

    $scope.updateVariables = function(resultMatrix) {
        $scope.useTab = resultMatrix.useTab;
        $scope.tabArray = resultMatrix.tabs;
        $scope.firstTabObj = $scope.tabArray[0];
    }

    $scope.hasTitle = function(obj) {
        if(obj.name == null || obj.name == '') {
            return false;
        }
        return true;
    }

    /**
     * Loop into the array to see if each object has the attr 'title'.
     *
     * In each object, add a new attr 'hasTitle' to indicate if it has or not.
     *
     *
     * @param array The object array
     *
     * @return The processed array
     */
    $scope.hasTitleInArray = function(array) {

        var newArray = [];

        if (array != null && array.length > 0) {
            $.each(array, function(idx, obj){
                obj.hasTitle = $scope.hasTitle(obj);

                newArray.push(obj);
            });
        }

        return newArray;
    }

    $scope.getPrintArray = function (tabObj) {
        if(tabObj == null) {
            return null;
        }

        return $scope.hasTitleInArray(tabObj.print);
    }

    $scope.getPlotArray = function(tabObj) {

        if(tabObj == null) {
            return null;
        }

        return $scope.hasTitleInArray(tabObj.plot);
    }

    $scope.getPlotFullUrl = function(plotObj) {

        if(plotObj == null) {
            return '';
        }

        return $scope.ocpuGate.successfulPackage.sessionLocation + "graphics/" + plotObj.n + "/png";
    }


    $scope.getTableArray = function(tabObj) {

        if(tabObj == null) {
            return null;
        }

        return $scope.hasTitleInArray(tabObj.table);
    }

    $scope.getTableHeaderArray = function (tableObj) {
        if(tableObj == null) {
            return null;
        }

        return tableObj.header;
    }

    $scope.getTableRowArray = function (tableObj) {
        if(tableObj == null) {
            return null;
        }

        return tableObj.value;
    }

    /**
     * Get an "ordered" row array according to the "header" array.
     *
     * For each row, it has a corresponding "object" inside the "table row array".
     * In order to help display each cell by using "ng-repeat", we need to build an array which has
     * the correct order.
     *
     * @param tableRowObj   The table object that includes the table cell values (in key-value paris)
     *
     * @return An array of table cell values with the order by the header.
     */
    $scope.getTableRow = function(tableRowObj, tableObj) {

        var headerArray = $scope.getTableHeaderArray(tableObj);
        var valueArray = [];

        if(tableObj == null) {
            return null;
        }

        $.each(headerArray, function(idx, header) {
            var value = tableRowObj[header];
            valueArray.push(value);
        });

        return valueArray;
    }

}]);