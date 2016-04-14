class WebApi::GuestController < BaseController
  def index
    render :json => {code: 1, msg: 'api.guest.index', data: "GuestController in web_api"} and return
  end

  def test
    if request.get?
      render :json => {code: 1, msg: "get 测试返回值 in web_api"} and return
    elsif request.post?
      render :json => {code: 1, msg: "post 测试返回值 in web_api"} and return
    elsif request.put?
      render :json => {code: 1, msg: "put 测试返回值 in web_api"} and return
    elsif request.delete?
      render :json => {code: 1, msg: "delete 测试返回值 in web_api"} and return
    end
  end
end