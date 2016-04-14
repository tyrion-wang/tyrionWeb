class GuestController < BaseController

  def index
    render :json => {code: 1, msg: 'guest.index', data: "GuestController"} and return
  end

  def visit
    render :json => {code: 1, msg: 'guest.visit', data: "Wellcome！This is Tyrion and Cherry's web~!"} and return
  end

  def test
    if request.get?
      render :json => {code: 1, msg: "get 测试返回值"} and return
    elsif request.post?
      render :json => {code: 1, msg: "post 测试返回值"} and return
    elsif request.put?
      render :json => {code: 1, msg: "put 测试返回值"} and return
    elsif request.delete?
      render :json => {code: 1, msg: "delete 测试返回值"} and return
    end
  end

end
