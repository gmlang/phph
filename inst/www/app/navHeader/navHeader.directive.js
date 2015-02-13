/**
 * Angular JS App - OpenCPUDemo
 *
 * Directive - Header Navigation Bar
 *
 */

navHeader.directive('navHeader', function(){
    return {
      restrict: 'E',
      templateUrl: 'app/navHeader/nav-header.html',
      controller: 'navHeaderController'
    };
});