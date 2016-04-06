class GuestController < ApplicationController
  def visit
    render :json => {code: 1, msg: 'guest.visit', data: "Wellcome！This is Tyrion and Cherry's web~!"} and return
  end
end
