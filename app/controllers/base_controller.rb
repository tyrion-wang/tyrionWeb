class BaseController < ActionController::Base

  before_filter :check_authenticated

  def check_authenticated
    return if Rails.env == 'test'
    if session[:user_id].blank? || session[:expires].blank? || (session[:expires].to_i < Time.now.to_i)
      render json: {result: RESULT[:failed], msg: t(:user_no_session)}, status: HTTP_STATUS[:session_timeout] and return
    else
      if session[:remember].blank?
        session[:expires] = MOBILE_EXPIRE_TIME.from_now.to_i
      else
        session[:expires] = 30.days.from_now.to_i
      end
    end
  end

end
