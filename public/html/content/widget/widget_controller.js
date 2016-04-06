/**
 * Created by Tyrion on 15/11/24.
 */
party.controller('widget_input_box_controller', function($scope){
    g_log('widget_input_box_controller');
    g_log('$scope.ngMaxlength', $scope.ngMaxlength);
});

//性别选择框
party.controller('widget_select_sex_controller', function ($scope, $timeout, api) {
    $scope.isShowList = false;
    $scope.sexValue = '保密';
    $scope.sexGroup = [{index:0, value:'保密'},{index:1, value:'男'},{index:2, value:'女'}];
    $scope.select = function(sex){
        $scope.sexValue = sex.value;
        $scope.gender = sex.index;
    };

    $scope.show = function(){
        $scope.isShowList = true;
    };

    $scope.hide = function(){
        $timeout(
            function() {
                $scope.isShowList = false;
            },
            200
        );
    };

    $scope.$watch('gender', function() {
        if($scope.gender != null){
            $scope.sexValue = $scope.sexGroup[$scope.gender].value;
        }
    });
});

