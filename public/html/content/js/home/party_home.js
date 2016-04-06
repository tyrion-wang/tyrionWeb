/**
 * Created by Tyrion on 15/11/23.
 */

//头部导航栏
party.controller('party_home_header_controller', function($scope, $location){
    g_log('party_home_header_controller');
    $scope.isActive = function (route) {
        var path = $location.path();
        var position = path.lastIndexOf('/', path.length);
        var result = path.substring(position, path.length);
        var reg = new RegExp("^/personal$");
        var r = path.match(reg);
        if (r != null) {
            result = '/home';
        }

        return route === result;
    };
});