class WebApi::ScheduleController < BaseController

  skip_before_filter :check_authenticated, :only => [:index]

  def index
    if request.get?
      render :json => {code: 1, msg: 'web_api/schedule', data: '1.this_week get/post/delete 2.next_week_get/post/delete'} and return
    elsif request.post?

    end
  end

  def this_week
    if request.post?
      content = params[:content]
      isFinish = params[:isFinish]
      rank = params[:rank]
      createTime = Time.now
      createSchedule(content, isFinish, createTime, rank)
    elsif request.get?
      get(0)
    end
  end

  def next_week
    if request.post?
      content = params[:content]
      isFinish = params[:isFinish]
      rank = params[:rank]
      createTime = Time.now + 7.day
      createSchedule(content, isFinish, createTime, rank)
    elsif request.get?
      get(1)
    end
  end

  def createSchedule(content, isFinish, create_time, rank)
    if content.blank?
      render :json => {code: 0, msg: 'content不能为空'} and return
    end

    user = User.find session[:user_id]

    if isFinish.blank?
      isFinish = false
    end

    if rank.blank?
      rank = 0
    elsif rank.to_i >= 5
      rank = 5
    elsif rank.to_i <= 0
      rank = 0
    end

    schedule = Schedule.new
    schedule.content = content
    schedule.isFinish = isFinish
    schedule.rank = rank
    schedule.created_at = create_time

    user.schedules << schedule
    # user.schedules.save!

    render :json => {code: 1, msg: '日程保存成功', data:schedule} and return
  end

  def get(week)
    user = User.find session[:user_id]

    @schedule = user.schedules.where(created_at: (Time.now.midnight - Time.now.wday.day + 1.day + (week*7).day)..(Time.now.midnight + (7-Time.now.wday).day + 1.day + (week*7).day))

    if @schedule.blank?
      render :json => {code: 0, msg: '未找到相符合的日程'} and return
    end

    render :json => {code: 0, data: @schedule} and return
  end
  
  def delete
    id = params[:id]
    if id.blank?
      render :json => {code: 0, msg: 'id不能为空'} and return
    end
    user = User.find session[:user_id]

    schedule = getSchedule(id)

    if schedule.blank?
      render :json => {code: 0, msg: '该日程不存在'} and return
    end
    user.schedules.destroy(id)
    render :json => {code: 1, msg: '删除id=' + id.to_s + '成功'} and return
  end

  def change
    ischange = false
    id = params[:id]
    content = params[:content]
    isFinish = params[:isFinish]
    rank = params[:rank]
    week = params[:week]

    if id.blank?
      render :json => {code: 0, msg: 'id不能为空'} and return
    end

    schedule = getSchedule(id)



    if !content.blank?
      schedule.content = content
      schedule.save!
      ischange = true
    end

    if !isFinish.nil?
      schedule.isFinish = isFinish
      schedule.save!
      ischange = true
    end

    if !rank.blank?
      schedule.rank = rank
      schedule.save!
      ischange = true
    end

    if !week.blank?
      schedule.created_at = schedule.created_at + (week.to_i*7).day
      schedule.save!
      ischange = true
    end

    if ischange
      render :json => {code: 1, msg: '修改成功'} and return
    end
    render :json => {code: 0, msg: '未做任何修改'} and return
  end

  def getSchedule(id)
    user = User.find session[:user_id]
    begin
      schedule = user.schedules.find(id)
    rescue ActiveRecord::RecordNotFound => e
      schedule = nil
    end

    return schedule
  end
end
