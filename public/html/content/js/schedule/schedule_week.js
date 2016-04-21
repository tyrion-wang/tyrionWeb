/**
 * Created by tyrion on 16/4/21.
 */
party.controller('party_schedule_this_week_controller', function($scope, api, $state){
    api.schedule.getThisWeek().then(function(result){
        if(result.data.code == 0){
            g_log('登录成功', result);
            $scope.thisWeekSchedule = result.data.data;
        }else{
            g_log('登录失败', result);
        }
    });

    api.schedule.getNextWeek().then(function(result){
        if(result.data.code == 0){
            g_log('登录成功', result);
            $scope.nextWeekSchedule = result.data.data;
        }else{
            g_log('登录失败', result);
        }
    });
});