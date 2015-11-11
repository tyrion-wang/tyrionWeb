class GuestController < ApplicationController
  def visit
    render :json => {code: 1, msg: 'guest.visit'} and return
  end
end
