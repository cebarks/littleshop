class MerchantsController < ApplicationController
  def dashboard
    @user = current_user
    render "users/show"
  end
end
