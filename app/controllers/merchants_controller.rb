class MerchantsController < ApplicationController
  def dashboard
    @user = current_user
    render "users/show"
  end

  def items
    @my_items = Item.where(user: current_user.id)
  end
end
