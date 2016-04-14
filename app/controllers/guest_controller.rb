class GuestController < ApplicationController
  def visit
    render :json => {code: 1, msg: 'guest.visit', data: "Wellcome！This is Tyrion and Cherry's web~!"} and return
  end

  def test
    render :json => {code: 1, msg: "测试返回值"} and return
  end
end
