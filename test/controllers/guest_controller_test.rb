require 'test_helper'

class GuestControllerTest < ActionController::TestCase
  test "should get visit" do
    get :visit
    assert_response :success
  end

end
