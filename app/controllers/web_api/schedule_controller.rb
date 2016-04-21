class WebApi::ScheduleController < BaseController
  def index
    render :json => {code: 1, msg: 'api.guest.index', data: "GuestController in web_api"} and return
  end

  def this_week
    if request.post?
      name = params[:name]
      state = params[:state]
      createTime = Time.now
      create(name, state, createTime)
    elsif request.get?
      get(0)
    end
  end

  def next_week
    if request.post?
      name = params[:name]
      state = params[:state]
      createTime = Time.now + 7.day
      create(name, state, createTime)
    elsif request.get?
      get(1)
    end
  end

  def create(name, state, create_time)
    if request.post?

      if name.blank?
        render :json => {code: 0, msg: "name不能为空"} and return
      end

      if session[:user_id].blank?
        render :json => {code: 1,result: RESULT[:failed], msg: t(:user_no_session)} and return
      end
      user = User.find session[:user_id]

      if state.blank?
        state = 0
      end

      schedule = Schedule.new
      schedule.name = name
      schedule.ownerId = user.id
      schedule.state = state
      schedule.created_at = create_time

      user.schedules << schedule
      # user.schedules.save!

      render :json => {code: 1, msg: "日程保存成功"} and return
    elsif request.get?
      render :json => {code: 1, msg: "请使用post方法参数为name:str type:int state:int"} and return
    end
  end

  def get(week)
    if request.get?
      if session[:user_id].blank?
        render :json => {code: 1,result: RESULT[:failed], msg: t(:user_no_session)} and return
      end
      user = User.find session[:user_id]

      # @schedule = Schedule.find_by_ownerId user.id
      @schedule = user.schedules.where(created_at: (Time.now.midnight - Time.now.wday.day + 1.day + (week*7).day)..(Time.now.midnight + (7-Time.now.wday).day + 1.day + (week*7).day))

      if @schedule.blank?
        render :json => {code: 0, msg: "未找到相符合的日程"} and return
      end

      render :json => {code: 0, data: @schedule} and return
    end
  end
end
