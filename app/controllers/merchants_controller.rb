class MerchantsController < ApplicationController

  def index
    @merchants = User.merchants
  end

  def dashboard
    @user = current_user
    render "users/show"
  end
end
