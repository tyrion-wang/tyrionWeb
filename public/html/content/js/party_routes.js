/**
 * Created by tyrion on 15-11-15.
 */
party.config(function ($stateProvider, $urlRouterProvider, $httpProvider, $locationProvider) {
    $urlRouterProvider.when("", "/guest");
    $stateProvider
        .state("user", {  // 个人
            abstract: true,
            templateUrl: "/html/user/user.html",
            controller: "user_Ctrl"
        })

        //游客界面
        .state("guest", {
            url: "/guest",
            views: {
                "@": {
                    templateUrl: "/html/content/html/guest/guest_home.html"
                }
            }
        })
});