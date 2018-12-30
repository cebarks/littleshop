class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:order_id])
    if current_user && current_user.default?
      require_user
    elsif
      current_user.admin?
      redirect_to admin_order_path(@order)
    end
  end

  def require_user
    render file: 'public/404', status: 404 unless current_user && current_user.default?
  end

end
