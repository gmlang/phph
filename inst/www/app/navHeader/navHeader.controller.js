/**
 * Angular JS App - OpenCPUDemo
 *
 * Controller - Header Navigation Bar
 *
 */

navHeader.controller('navHeaderController', ['$scope', '$location', function($scope, $location){
    $scope.appHeaderName = "Survival Analysis App Demo";
    $scope.appHeaderMenus = dataHeaderMenu;

    /**
     * Function used to determine if the page is on.
     *
     * If so, will add the class attribute "active".
     */
    $scope.isActive = function(viewLocation) {
        return viewLocation === $location.path();
    };

}]);