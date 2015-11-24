/**
 * Created by tyrion on 15-11-15.
 */
var getWindowSize = function () {
    var windowSize = new Object();
    if (window.innerWidth)
        winWidth = window.innerWidth;
    else if ((document.body) && (document.body.clientWidth))
        winWidth = document.body.clientWidth;
    // 获取窗口高度
    if (window.innerHeight)
        winHeight = window.innerHeight;
    else if ((document.body) && (document.body.clientHeight))
        winHeight = document.body.clientHeight;
    // 通过深入 Document 内部对 body 进行检测，获取窗口大小
    if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
        winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
    }

    windowSize.width = winWidth;
    windowSize.height = winHeight;
    return windowSize;
};

//设计分辨率 高度
var designHeight = 1200;

//调整成屏幕尺寸
party.directive('myGuestJarallaxInit', [function() {
    return {
        restrict: 'A',
        scope:{
            myGuestJarallaxInit:"@"
        },
        link:function($scope, $element, $attrs, $ctrl){
            var size = getWindowSize();
            var multiple = parseFloat($scope.myGuestJarallaxInit);
            var heightMul = size.height*multiple;
            //g_log('in_multiple', multiple);
            //g_log('in_height', height);

            //设置撑开屏幕的高度
            $element.height(heightMul);

            jarallaxInit();
        }
    }
}]);

//自定义输入框
party.directive('widgetImputBox', [function() {
    return {
        restrict: 'E',
        scope:{
            type:"@",
            placeholder:"@"
        },
        require: 'ngModel',
        templateUrl:'/html/content/widget/widget_inputBox.html',
        controller:'widget_input_box_controller'
    }
}]);
