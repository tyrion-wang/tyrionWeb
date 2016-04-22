class UserController < BaseController

  skip_before_filter :check_authenticated, :only => [:login, :create, :check_account, :check_nickname, :info, :update]
  
  def login
    email     = params[:email]
    cellphone = params[:cellphone]
    password  = params[:password]
    remember  = params[:remember].to_i

    if email.blank? && cellphone.blank?
      render :json => {code:1, result: RESULT[:failed], msg: t(:login_email_or_phone)} and return
    end

    unless User.test_simple_password(password)
      render :json => {code: 1,result: RESULT[:failed], msg: t(:users_password_invalid)} and return
    end

    if email.blank?
      loginName = cellphone.strip;
    else
      loginName = email.strip;
    end


    user = User.authenticate loginName, password
    unless user
      render :json => {code: 1,result: RESULT[:failed], msg: t(:users_login_failed)} and return
    end

    session[:user_id] = user.id
    session[:name] = user.name
    if remember == 1
      session[:remember] = true
      session[:expires] = 30.days.from_now.to_i # 设置session超时时间
    else
      session[:expires] = MOBILE_EXPIRE_TIME.from_now.to_i # 设置session超时时间
    end

    render :json => {code: 0, user: user} and return
  end

  def create
    name = params[:name]
    password = params[:password]
    email = params[:email]
    cellphone = params[:cellphone]
    gender = params[:gender]
    age = params[:age]
    brief = params[:brief]
    portrait_img = params[:portrait_img]

    if name.blank?
      render :json => {code:1, result: RESULT[:failed], msg: t(:users_name_empty)} and return
    end

    if name.to_s.length > 20
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_name_too_long)} and return
    end

    unless User.test_simple_password(password)
      render :json => {code: 1,result: RESULT[:failed], msg: t(:users_password_invalid)} and return
    end

    if email.blank? && cellphone.blank?
      render :json => {code:1, result: RESULT[:failed], msg: t(:email_or_phone)} and return
    end

    if User.find_account(email, cellphone)
      render :json => {code:1, result: RESULT[:failed], msg: t(:user_account_occupied)} and return
    end

    if gender.blank?
      gender=0;
    end

    unless User.test_gender(gender)
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_gender_error)} and return
    end

    if age.blank?
      age=0;
    end

    unless User.test_age(age)
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_age_error)} and return
    end

    if portrait_img.blank?
      portrait_img='img_default_portrait.png';
    end

    user = User.new
    user.name = name.strip
    user.password = password.strip
    if !email.blank?
      user.email = email.strip
    end
    if !cellphone.blank?
      user.cellphone = cellphone.strip
    end
    user.gender = gender
    user.age = age
    if !brief.blank?
      user.brief = brief.strip
    end

    user.portrait_img = portrait_img.strip

    user.save!
    render :json => {code: 0, msg: t(:user_create_successed)} and return
  end

  def check_account

    email = params[:email]
    cellphone = params[:cellphone]
    if email.blank? && cellphone.blank?
      render :json => {code: 0, msg: t(:user_check_account_error)} and return
    end

    if User.find_account(email, cellphone)
      render :json => {code: 1, msg: t(:user_name_occupied)} and return
    else
      render :json => {code: 0, msg: t(:user_name_usable)} and return
    end
  end

  def check_nickname
    nickname = params[:nickname]
    if nickname.blank?
      render :json => {code: 0, msg: t(:user_check_nickname_error)} and return
    end

    user = User.find_by_name nickname

    if user.blank?
      render :json => {code: 0, msg: t(:user_nickname_usable)} and return
    end
    render :json => {code: 1, msg: t(:user_nickname_occupied)} and return
  end

  def info
    if session[:user_id].blank?
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_no_session)} and return
    end
    user = User.find session[:user_id]
    render :json => {code: 0,result: RESULT[:ok], user: user.private_info} and return
  end

  def logout
    session.clear
    render :json => {code: 0,result: RESULT[:ok]}
  end

  # 更新用户信息
  def update
    if session[:user_id].blank?
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_no_session)} and return
    end
    name = params[:name]
    gender = params[:gender]
    age = params[:age]
    brief = params[:brief]
    portrait_img = params[:portrait_img]

    if !name.blank? && name.length > 20
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_name_too_long)} and return
    end

    if !gender.nil? && !User.test_gender(gender)
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_gender_error)} and return
    end

    if !age.nil? && !User.test_age(age)
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_age_error)} and return
    end

    if !brief.blank? && brief.length > 500
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_brief_error)} and return
    end


    user = User.find session[:user_id]

    user.name   = name unless name.blank?
    user.gender = gender.to_i unless gender.blank?
    user.age = age.to_i unless age.blank?
    user.name   = name unless name.blank?
    user.brief   = brief unless brief.nil?
    if portrait_img.blank?
      portrait_img='img_default_portrait.png';
    end
    user.portrait_img   = portrait_img
    user.save!

    session[:name] = user.name

    render :json => {code: 0,result: RESULT[:ok], user: user.private_info}

  end

end
