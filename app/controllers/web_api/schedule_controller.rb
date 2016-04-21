class WebApi::ScheduleController < BaseController
  def index
    render :json => {code: 1, msg: 'api.guest.index', data: "GuestController in web_api"} and return
  end

  def create
    if request.post?
      name = params[:name]
      state = params[:state]

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

      user.schedules << schedule
      # user.schedules.save!

      render :json => {code: 1, msg: "日程保存成功"} and return
    elsif request.get?
      render :json => {code: 1, msg: "请使用post方法参数为name:str type:int state:int"} and return
    end
  end

  def get
    if request.get?
      if session[:user_id].blank?
        render :json => {code: 1,result: RESULT[:failed], msg: t(:user_no_session)} and return
      end
      user = User.find session[:user_id]

      # @schedule = Schedule.find_by_ownerId user.id
      @schedule = user.schedules
      if @schedule.blank?
        render :json => {code: 0, msg: "未找到相符合的日程"} and return
      end

      render :json => {code: 0, data: @schedule} and return
    end
  end
end
