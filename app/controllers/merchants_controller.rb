class MerchantsController < ApplicationController
  def dashboard
    @user = current_user
    render "users/show"
  end

  def index
    @merchant = User.find(current_user.id)
  
  end
end
