/**
 * Created by tyrion on 15-11-15.
 */
party.config(function ($stateProvider, $urlRouterProvider, $httpProvider, $locationProvider) {
    $urlRouterProvider.when("", "/home");
    /**
     * @return {string}
     */
    HTML_PATH = function(path){
        return "/html/content/html" + path;
    };

    $stateProvider
        //游客界面
        .state("guest", {
            url: "/guest",
            views: {
                "@": {
                    templateUrl: HTML_PATH("/guest/guest_home.html")
                }
            }
        })
        .state("home", {
            url: "/home",
            views: {
                "@": {
                    templateUrl: HTML_PATH('/home/home.html')
                },
                "homeHeader@home": {
                    templateUrl: HTML_PATH('/home/home_header.html'),
                    controller: 'party_home_header_controller'
                },
                "@home": {
                    templateUrl: HTML_PATH('/home/home_content.html')
                },
                "homeFooter@home": {
                    templateUrl: HTML_PATH('/home/home_footer.html')
                }
            }
        })
        .state("home.login", {
            url: "/login",
            views: {
                "@home": {
                    templateUrl: HTML_PATH('/passport/passport_login.html'),
                    controller: 'party_passport_login_controller'
                }
            }
        })
        .state("home.register", {
            url: "/register",
            views: {
                "@home": {
                    templateUrl: HTML_PATH('/passport/passport_register.html'),
                    controller: 'party_passport_register_controller'
                }
            }
        })
        .state("home.guest", {
            url: "/guest",
            views: {
                "@home": {
                    templateUrl: HTML_PATH('/guest/guest_home.html')
                }
            }
        })
});