class UserController < ApplicationController
  def login
    render :json => {code: 1, msg: 'user.login'} and return
  end

  def register
    render :json => {code: 1, msg: 'user.register'} and return
  end
end
