class MerchantsController < ApplicationController

  def dashboard
    if current_user && current_user.merchant?
      @user = current_user
      render "users/show"
    else
      render file: 'public/404', status: 404
    end
  end

  def index
    @merchant = User.find(current_user.id)
  end

  def items
    if current_user && current_user.merchant?
      @my_items = Item.where(user: current_user.id)
    else
      render file: 'public/404', status: 404
    end
  end
end
