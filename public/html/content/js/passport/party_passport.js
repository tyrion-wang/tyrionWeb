/**
 * Created by Tyrion on 15/11/24.
 */
party.controller('party_passport_login_controller', function($scope, api){
    $scope.show = true;

});


party.controller('party_passport_register_controller', function($scope, api, $http){
    g_log('party_passport_register_controller');
    $scope.isUserRegisterFinish = false;
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

    $scope.checkAccount = function(){
        $scope.account_blur = true;
        var account = $scope.account + '';
        if(account.indexOf('@') != -1){
            var email = $scope.account;
        }else{
            var cellphone = $scope.account;
        }
        api.passport.check({'email': email, 'cellphone': cellphone}).then(function(result){
            g_log('result', result);
        });
    };

    $scope.userRegister = function(){
        $scope.isUserRegisterFinish = true;
    };

    $scope.completeInfo = function(){
        //$http.get('https://101.200.211.156/user/check?email=a@a.com');
        api.passport.check({'email': 'a@a.com'}).then(function(result){
            g_log('result', result);
        });
    };
});