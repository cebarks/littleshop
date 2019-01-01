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

  def update
    this_order = Order.find(params[:id])
    target_oi = OrderItem.where(order: this_order, item: Item.find(params[:item_id]))
    target_oi.first.fulfillment = true
    target_oi.first.save

    target_item = Item.find(params[:item_id])
    target_item.inventory_qty -= target_oi.first.quantity
    target_item.save
    # require "pry"; binding.pry
    flash[:success] = "The item has been fulfilled."
    if this_order.completely_fulfilled?
      this_order.status = "complete"
      this_order.save
    end
    redirect_to dashboard_order_path(this_order)
  end

  private

  def require_merchant
    render file: 'public/404', status: 404 unless current_user && current_user.merchant?
  end
end
