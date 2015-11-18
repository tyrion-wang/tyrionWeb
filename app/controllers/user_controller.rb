RESULT = {
    failed: 'failed',
    ok: 'ok',
}

class UserController < ApplicationController
  def login
    email     = params[:email]
    cellphone = params[:cellphone]
    password  = params[:password]

    if email.blank? && cellphone.blank?
      render :json => {code:1, result: RESULT[:failed], msg: t(:login_email_or_phone)} and return
    end

    unless User.test_simple_password(password)
      render :json => {code: 1,result: RESULT[:failed], msg: t(:users_password_invalid)} and return
    end

    # render :json => {code: 1, email: email, cellphone: cellphone, password: password} and return

    if email.blank?
      loginName = cellphone.strip;
    else
      loginName = email.strip;
    end


    user = User.authenticate loginName, password
    unless user
      render :json => {code: 1,result: RESULT[:failed], msg: t(:users_login_failed)} and return
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

    if name.to_s.length > 10
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_name_too_long)} and return
    end

    unless User.test_simple_password(password)
      render :json => {code: 1,result: RESULT[:failed], msg: t(:users_password_invalid)} and return
    end

    if email.blank? && cellphone.blank?
      render :json => {code:1, result: RESULT[:failed], msg: t(:email_or_phone)} and return
    end

    if gender.blank?
      gender=0;
    end

    unless User.test_gender(gender.to_s)
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_gender_error)} and return
    end

    if age.blank?
      age=0;
    end

    unless User.test_age(age.to_s)
      render :json => {code: 1,result: RESULT[:failed], msg: t(:user_age_error)} and return
    end

    if brief.blank?
      brief='null';
    end

    if portrait_img.blank?
      portrait_img='img_default_portrait.png';
    end

    user = User.new
    user.name = name.strip
    user.password = password.strip
    user.email = email.strip
    user.cellphone = cellphone.strip
    user.gender = gender
    user.age = age
    user.brief = brief.strip
    user.portrait_img = portrait_img.strip

    user.save!
    render :json => {code: 0, msg: t(:user_create_successed)} and return
    # render :json => {code: 0, name: name, password:password, email: email, cellphone: cellphone, gender: gender, age: age, brief: brief, portrait_img: portrait_img, msg: t(:user_create_successed)} and return
  end
end
