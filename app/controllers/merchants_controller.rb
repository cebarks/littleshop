class MerchantsController < ApplicationController
  before_action :require_merchant

  def dashboard
    @user = current_user
    @orders = Order.joins(:items, :order_items).select("orders.*").where("items.user_id": @user).where(status: 0).distinct
    # require "pry"; binding.pry
  end

  def items
    @my_items = Item.where(user: current_user.id)
  end

  def order_show
    @order = Order.find(params[:id])
    @user = current_user
    @my_orders = Order.joins(:items, :order_items).select("orders.*").where("items.user_id": @user.id).where(status: 0).distinct
    @my_order_items = Order.joins(:items, :order_items).select("items.*").where("items.user_id": @user.id).distinct
    render 'orders/show'
  end

  private

  def require_merchant
    render file: 'public/404', status: 404 unless current_user && current_user.merchant?
  end
end
