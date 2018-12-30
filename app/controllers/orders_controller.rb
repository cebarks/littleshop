class OrdersController < ApplicationController

  def show
    require_user
    @order = Order.find(params[:order_id])
  end

  def require_user
    render file: 'public/404', status: 404 unless current_user && current_user.default?
  end

end
