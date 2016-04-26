/**
 * Created by tyrion on 16/4/21.
 */
party.controller('party_schedule_this_week_controller', function($scope, api, $state){
    api.schedule.getThisWeek().then(function(result){
        if(result.data.code == 0){
            g_log('getThisWeek', result);
            $scope.thisWeekSchedule = [];
        }else{
            g_log('getThisWeek', result);
            $scope.thisWeekSchedule = result.data.data;
        }
    });

    api.schedule.getNextWeek().then(function(result){
        if(result.data.code == 0){
            g_log('getNextWeek', result);
            $scope.nextWeekSchedule = [];
        }else{
            g_log('getNextWeek', result);
            $scope.nextWeekSchedule = result.data.data;
        }
    });

    $scope.delete = function(schedule){
        g_log('delete', schedule.id);
        var scheduleId = schedule.id;

        for(var i=0; i<$scope.thisWeekSchedule.length; i++){
            if($scope.thisWeekSchedule[i].id == scheduleId){
                $scope.thisWeekSchedule.splice(i,1);
                return
            }
        }

        for(var i=0; i<$scope.nextWeekSchedule.length; i++){
            if($scope.nextWeekSchedule[i].id == scheduleId){
                $scope.nextWeekSchedule.splice(i,1);
                return
            }
        }
    }

    $scope.createThisWeek = function(schedule){
        g_log('createThisWeek', schedule);
        g_log('length', $scope.thisWeekSchedule.length);
        $scope.thisWeekSchedule[$scope.thisWeekSchedule.length] = schedule;
    }

    $scope.createNextWeek = function(schedule){
        g_log('createNextWeek', schedule);
        $scope.nextWeekSchedule[$scope.nextWeekSchedule.length] = schedule;
    }
});