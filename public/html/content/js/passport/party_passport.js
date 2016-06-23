/**
 * Created by Tyrion on 15/11/24.
 */
party.controller('party_passport_login_controller', function($scope, api, $state){
    $scope.show = true;
    $scope.isLogin = false;
    $scope.login = function(){

        if($scope.account.indexOf('@') != -1){
            var email = $scope.account;
        }else{
            var cellphone = $scope.account;
        }
        g_log('登录');
        api.passport.login({email: email, cellphone: cellphone, password: $scope.password}).then(function(result){

            if(result.data.code == 0){
                g_log('登录成功', result);
                $scope.isLogin = true;
                var user = result.data.user;
                $scope.nickname = user.name;
                $scope.email = user.email;
                $scope.cellphone = user.cellphone;
                $scope.gender = user.gender;
                $scope.brief = user.brief;

                $state.go('home.schedule');
            }else{
                g_log('登录失败', result);
            }
        });
    }
});

party.controller('party_passport_logout_controller', function($scope, api, $state){
    $scope.show = true;
    $scope.isLogin = false;
    api.passport.logout().then(function(result){
        if(result.data.code == 0){
            g_log('注销成功', result);
        }else{
            g_log('注销失败', result);
        }
    });
});


party.controller('party_passport_register_controller', function($scope, api, $state){
    //g_log('party_passport_register_controller');
    $scope.isRegisterFinish = false;
    $scope.isUserRegisterFinish = false;
    $scope.isPasswordDifferent = false;
    $scope.$watch('passWord1', function() {
        if($scope.passWord1 != $scope.passWord2){
            $scope.isPasswordDifferent = true;
        }else{
            $scope.isPasswordDifferent = false;
        }
    });

    var init = function(){
        $scope.gender = 0;
    };

    init();

    var register = function(){
        //g_log('account', $scope.account);
        //g_log('passWord1', $scope.passWord1);
        //g_log('passWord2', $scope.passWord2);
        //g_log('nickname', $scope.nickname);
        //g_log('gender', $scope.gender);
        //g_log('brief', $scope.brief);
        if($scope.account.indexOf('@') != -1){
            var email = $scope.account;
        }else{
            var cellphone = $scope.account;
        }

        if($scope.passWord2 == $scope.passWord1){
            api.passport.reginster({name: $scope.nickname, password: $scope.passWord2, email: email, cellphone: cellphone, gender: $scope.gender, brief: $scope.brief}).then(function(result){
                g_log('注册结果', result)
                if(result.data.code == 0){
                    //$state.go('home');
                    $scope.isRegisterFinish = true;
                }
            });
        }
    };

    $scope.$watch('passWord2', function() {
        if($scope.passWord1 != $scope.passWord2){
            $scope.isPasswordDifferent = true;
        }else{
            $scope.isPasswordDifferent = false;
        }
    });

    $scope.checkAccount = function(callback){
        $scope.account_blur = true;
        var account = $scope.account + '';
        if(account.indexOf('@') != -1){
            var email = account;
        }else{
            var cellphone = account;
        }
        //g_log('email', email);
        //g_log('cellphone', cellphone);
        api.passport.checkAccount({'email': email, 'cellphone': cellphone}).then(function(result){
            callback(result)
        });
    };

    $scope.checkNickname = function(callback){
        //g_log('nickname', $scope.nickname);
        api.passport.checkNickname({'nickname': $scope.nickname}).then(function(result){
            callback(result)
        });
    };

    $scope.userRegister = function(){
        if($scope.accountOK){
            $scope.isUserRegisterFinish = true;
        }else{
            $scope.checkAccount(function(result){
                if(result.data.code == 0){
                    //g_log('result', result);
                    $scope.isUserRegisterFinish = true;
                }
            });
        }
    };

    $scope.completeInfo = function(){
        if($scope.nicknameOK){
            register();
        }else{
            $scope.checkNickname(function(result){
                if(result.data.code == 0){
                    //g_log('result', result);
                    $scope.isUserRegisterFinish = true;
                }
            });
        }
    };

    //$scope.test = function(){
    //    api.passport.reginster({name: 'tyas1', password: 'asd123', email: 'q@q1.com', cellphone: '13435212452', gender:1}).then(function(result){
    //        g_log('注册结果', result)
    //    });
    //}
});