/**
 * Created by tyrion on 15-11-11.
 */

party.controller("rootController", function($scope, $rootScope, api, $state){
   g_log('rootController', 'init');
   api.passport.autoLogin().then(function(result){

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
   $rootScope.IMG_PATH = '/html/resource/img/';
});
