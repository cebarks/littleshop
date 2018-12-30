class MerchantsController < ApplicationController
  before_action :require_merchant

  def dashboard
    @user = current_user
    render "users/show"
  end

  def items
    @my_items = Item.where(user: current_user.id)
  end

  private

  def require_merchant
    render file: 'public/404', status: 404 unless current_user && current_user.merchant?
  end
end
