/**
 * Created by Tyrion on 15/11/24.
 */
party.controller('party_passport_login_controller', function($scope){
    $scope.show = true;

});


party.controller('party_passport_register_controller', function($scope){
    g_log('party_passport_register_controller');

    $scope.isPasswordDifferent = false;
    $scope.$watch('passWord1', function() {
        if($scope.passWord1 != $scope.passWord2){
            $scope.isPasswordDifferent = true;
        }else{
            $scope.isPasswordDifferent = false;
        }
    });

    $scope.$watch('passWord2', function() {
        if($scope.passWord1 != $scope.passWord2){
            $scope.isPasswordDifferent = true;
        }else{
            $scope.isPasswordDifferent = false;
        }
    });
});