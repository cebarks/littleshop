class MerchantsController < ApplicationController
  before_action :require_merchant

  def dashboard
    @user = current_user
    @orders = Order.joins(:items, :order_items).select("orders.*").where("items.user_id": @user).where(status: 0).distinct
  end

  def items
    @my_items = Item.where(user: current_user.id)
  end

  def order_show
    @order = Order.find(params[:id])
    render 'orders/show'
  end

  private

  def require_merchant
    render file: 'public/404', status: 404 unless current_user && current_user.merchant?
  end
end
