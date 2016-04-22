/**
 * Created by tyrion on 16/4/21.
 */
party.controller('party_schedule_this_week_controller', function($scope, api, $state){
    api.schedule.getThisWeek().then(function(result){
        if(result.data.code == 0){
            g_log('getThisWeek', result);
            $scope.thisWeekSchedule = result.data.data;
        }else{
            g_log('getThisWeek', result);
        }
    });

    api.schedule.getNextWeek().then(function(result){
        if(result.data.code == 0){
            g_log('getNextWeek', result);
            $scope.nextWeekSchedule = result.data.data;
        }else{
            g_log('getNextWeek', result);
        }
    });

    $scope.completeSchedule = function(){
        g_log('completeSchedule');
        g_log($scope.schedule_content);
        g_log($scope.state);

        api.schedule.thisWeek({name:$scope.schedule_content, state:$scope.state}).then(function(result){
            g_log(result)
        })

    };
});