class MerchantsController < ApplicationController
  before_action :require_merchant

  def dashboard
    @user = current_user
    @orders = Order.joins(:items, :order_items).select("orders.*").where("items.user_id": @user).where(status: 0).distinct

    @stats = {}

    @stats[:top_5_items] = @user.top_5_items.map(&:name).join(', ')
    @stats[:items_sold] = @user.items_sold
    @stats[:items_sold_percentage] = @user.items_sold_percentage.round(3) * 100
    @stats[:top_3_states] = @user.top_3_states.join(', ')
    @stats[:top_3_city_states] = @user.top_3_city_states.join('; ')
    @stats[:top_customer_order_count] = @user.top_customer_by_order_count
    @stats[:top_customer_quantity] = @user.top_customer_by_quantity
    @stats[:top_customer_revenue] = @user.top_3_customers_by_revenue.join(', ')
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
