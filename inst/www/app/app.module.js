/**
 * Angular JS App - OpenCPUDemo
 *
 * Root App Modules Definitions
 *
 */

var opencpuDemoApp = angular.module("opencpuDemo", [
    'ngRoute',

    'opencpuGateModule',
    'opencpuDemo.navHeader'
]);


/**
 * Filter: reverse
 *
 * Used to "reverse" the list
 */
opencpuDemoApp.filter('reverse', function() {
    return function(items) {
        return items.slice().reverse();
    };
});
