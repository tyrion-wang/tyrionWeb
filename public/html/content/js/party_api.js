/**
 * Created by Tyrion on 15/11/26.
 */
party.factory("api", function ($http) {
    var DOMAIN_NAME = 'http://101.200.211.156/';
    //var DOMAIN_NAME = 'http://0.0.0.0:3000/';
    var getApi = function (url) { return DOMAIN_NAME + url; };

    return {
        passport: {
            check: function (data) { return $http.get(getApi("user/check"), { params: data }); },
            reginster: function (data) { return $http.post(getApi("user/create"), data); },
            login: function (data) { return $http.post(getApi("api/users/login"), data); }
        }
    };
});