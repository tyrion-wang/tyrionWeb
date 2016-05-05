/**
 * Created by Tyrion on 15/11/24.
 */
party.controller('widget_input_box_controller', function($scope){
    g_log('widget_input_box_controller');
    g_log('$scope.ngMaxlength', $scope.ngMaxlength);
});

//性别选择框
party.controller('widget_select_sex_controller', function ($scope, $timeout, api) {
    $scope.isShowList = false;
    $scope.sexValue = '保密';
    $scope.sexGroup = [{index:0, value:'保密'},{index:1, value:'男'},{index:2, value:'女'}];
    $scope.select = function(sex){
        $scope.sexValue = sex.value;
        $scope.gender = sex.index;
    };

    $scope.show = function(){
        $scope.isShowList = true;
    };

    $scope.hide = function(){
        $timeout(
            function() {
                $scope.isShowList = false;
            },
            200
        );
    };

    $scope.$watch('gender', function() {
        if($scope.gender != null){
            $scope.sexValue = $scope.sexGroup[$scope.gender].value;
        }
    });
});

//日程单条计划Item
party.controller('widget_schedule_item_controller', function ($scope, api) {
    $scope.schedule = JSON.parse($scope.data);

    if($scope.isEmergency === "true"){
        $scope.isEmergency = true
    }else{
        $scope.isEmergency = false
    }
    $scope.updateSelection = function($event, schedule){
        if(schedule.isFinish){
            schedule.isFinish = false;
            g_log('修改为未完成')
            api.schedule.change({id:schedule.id, isFinish:false}).then(function(result){
                g_log(result)
            });
        }else{
            schedule.isFinish = true;
            g_log('修改为完成')
            api.schedule.change({id:schedule.id, isFinish:true}).then(function(result){
                g_log(result)
            });
        }
    };

    $scope.deleteSchedule = function(schedule){
        g_log('deleteSchedule', schedule.id);
        api.schedule.delete({id:schedule.id}).then(function(result){
            $scope.delete(schedule);
        });
    }
});

//创建日程box
party.controller('widget_schedule_create_box', function ($scope, api) {
    $scope.createSchedule = function(){
        var scheduleContent = $scope.scheduleInput;
        if(scheduleContent){
            $scope.scheduleInput = "";
            if($scope.week == 0){
                g_log('本周日程', scheduleContent);
                api.schedule.thisWeek({content:scheduleContent}).then(function(result){
                    g_log(result);
                    $scope.data = result.data;
                    $scope.create($scope.data);
                })
            }else if($scope.week == 1){
                g_log('下周日程', scheduleContent);
                api.schedule.nextWeek({content:scheduleContent}).then(function(result){
                    g_log(result);
                    $scope.data = result.data;
                    $scope.create($scope.data);
                })
            }
        }
    }
});

