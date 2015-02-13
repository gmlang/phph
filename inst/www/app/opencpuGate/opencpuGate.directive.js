/**
 * Angular JS Module - OpenCPU Gate
 *
 * Directive - Show results from 'R'
 *
 */

opencpuGateModule.directive('opencpuGate', function(opencpuGateService){

    var linkFunc = function(scope, elements, attributes) {

        scope.$watch(
            function(){
                return opencpuGateService.updated;
            },
            function (newVal, oldVal) {
                // If "updated" is true, start to update the DOM
                if(newVal) {

                    opencpuGateService.prepResultMatrix();
                    console.log(opencpuGateService.resultMatrix);
                    scope.updateVariables(opencpuGateService.resultMatrix);


                    opencpuGateService.updated = false;
                }
            }
        );

    };


    return {
        restrict: 'E',
        templateUrl: 'app/opencpuGate/opencpu-gate.html',
        controller: 'opencpuGateController',
        link: linkFunc
    };
});