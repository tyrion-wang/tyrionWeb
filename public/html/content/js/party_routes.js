/**
 * Created by tyrion on 15-11-15.
 */
party.config(function ($stateProvider, $urlRouterProvider, $httpProvider, $locationProvider) {
    $urlRouterProvider.when("", "/guest");
    $stateProvider
        
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