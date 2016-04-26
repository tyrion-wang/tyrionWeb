/**
 * Created by Tyrion on 15/11/26.
 */
party.factory("api", function ($http) {
    //var DOMAIN_NAME = 'http://101.200.211.156/';
    var DOMAIN_NAME = 'http://0.0.0.0:3000/';
    var getApi = function (url) { return DOMAIN_NAME + url; };

    return {
        passport: {
            checkAccount: function (data) { return $http.get(getApi("user/check_account"), { params: data }); },
            checkNickname: function (data) { return $http.get(getApi("user/check_nickname"), { params: data }); },
            reginster: function (data) { return $http.post(getApi("user/create"), data); },
            reginster_get: function (data) { return $http.get(getApi("user/create"), { params: data }); },
            login: function (data) { return $http.get(getApi("user/login"), { params: data }); }
        },
        schedule: {
            getThisWeek: function () { return $http.get(getApi("web_api/schedule/this_week")); },
            getNextWeek: function () { return $http.get(getApi("web_api/schedule/next_week")); },
            thisWeek: function (data) { return $http.post(getApi("web_api/schedule/this_week"), data); },
            nextWeek: function (data) { return $http.post(getApi("web_api/schedule/next_week"), data); },
            change: function (data) { return $http.post(getApi("web_api/schedule/change"), data); },
            delete: function (data) { return $http.post(getApi("web_api/schedule/delete"), data); },
        }
    };
});