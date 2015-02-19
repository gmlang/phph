/**
 * Angular JS App - OpenCPUDemo
 *
 * Root App Routes Config
 *
 */

opencpuDemoApp.config([ '$routeProvider', '$locationProvider',
    function($routeProvider, $locationProvider){
        // Use the HTML5 History API
        $locationProvider.html5Mode(false);

        // Config the routes
        $routeProvider
            .when('/', {
                templateUrl: 'app/page/page-home.html',
                controller: 'pageHomeController'
            })
            .when('/km', {
                templateUrl: 'app/page/page-km.html',
                controller: 'pageKmController'
            })
            .when('/cox', {
                templateUrl: 'app/page/page-cox.html',
                controller: 'pageCoxController'
            })
            .when('/po', {
                templateUrl: 'app/page/page-po.html',
                controller: 'pagePoController'
            })
            .when('/phph', {
                templateUrl: 'app/page/page-phph.html',
                controller: 'pagePhphController'
            })
            .otherwise({
                redirectTo: '/'
            });
    }]);


