/**
 * Created by Tyrion on 15/11/27.
 */
party.filter('filter_gender', function () {
    return function(input){
        var gender = parseInt(input);
        switch(gender){
            case 0:
                input = '保密';
                break;
            case 1:
                input = '男';
                break;
            case 2:
                input = '女';
                break;
            default :
                input = '保密';
                break;
        }
        return input;
    };
});

party.filter('filter_friendTime', function () {
    return function(input){
        function Time(input) {
            Date.prototype.Format = function(fmt)
            {
                var o = {
                    "M+" : this.getMonth()+1,                 //月份
                    "d+" : this.getDate(),                    //日
                    "h+" : this.getHours(),                   //小时
                    "m+" : this.getMinutes(),                 //分
                    "s+" : this.getSeconds(),                 //秒
                    "q+" : Math.floor((this.getMonth()+3)/3), //季度
                    "S"  : this.getMilliseconds()             //毫秒
                };
                if(/(y+)/.test(fmt))
                    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
                for(var k in o)
                    if(new RegExp("("+ k +")").test(fmt))
                        fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
                return fmt;
            };

            var timeFormat = (new Date(input)).Format("yyyy/MM/dd/hh/mm/ss");
            var time = new Array();
            time=timeFormat.split("/");
            this.year = time[0];
            this.month = time[1];
            this.day = time[2];

            this.hour = time[3];
            this.minute = time[4];
            this.second = time[5];

        }

        var past = new Time(input*1000);
        var now = new Time((new Date()).getTime());

        var timeResult = "";

        var years = now.year - past.year;
        var months = now.month - past.month;
        var days = now.day - past.day;
        if(years == 0 && months == 0){
            if(days<=0){
                timeResult = "今天 " + past.hour + ":" + past.minute;
            }else if(days==1){
                timeResult = "昨天 " + past.hour + ":" + past.minute;
            }else{
                timeResult = past.year + "-" + past.month + "-" + past.day;
            }
        }else{
            timeResult = past.year + "-" + past.month + "-" + past.day;
        }

        return timeResult;
    };
});