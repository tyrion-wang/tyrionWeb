class GuestController < ApplicationController
  def visit
    render :json => {code: 1, msg: 'guest.visit', data: 'Wellcome'} and return
  end
end
