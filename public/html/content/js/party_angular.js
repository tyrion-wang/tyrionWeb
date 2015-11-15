/**
 * Created by tyrion on 15-11-11.
 */
var party = angular.module("party", ['ngCookies', 'ngMessages', 'ui.router']);

var isDebug = true;
var g_log = function (name, log) {
    if (isDebug) {
        if (log == undefined) {
            console.log(name);
            return;
        }
        console.log(name, log);
    }
};

party.factory("WinSize", function () {
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
    var size = getWindowSize();
    return {
        get: function () {
            return size;
        },
        width: function () {
            return size.width;
        },
        height: function () {
            return size.height;
        },
        getMultiple: function (multiple) {
            var tempSize = Object.create({ width: 0, height: 0 });
            tempSize.width = parseInt(size.width * multiple);
            tempSize.height = parseInt(size.height * multiple);
            return tempSize;
        },
        widthMultiple: function (multiple) {
            return parseInt(size.width * multiple);
        },
        heightMultiple: function (multiple) {
            return parseInt(size.height * multiple);
        }
    }
});