class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:order_id])
    if current_user && current_user.default?
      require_user
    elsif
      current_user.admin?
      redirect_to admin_order_path(@order)
    end
    @user = current_user

  end

  def edit
  end

  def update
    order = Order.find(params[:order_id])
    if current_user && current_user.default?
      order.cancel_all(order)
      order.save
      redirect_to profile_path
    elsif
      current_user && current_user.admin?
      order.cancel_all(order)
      order.save
      redirect_to admin_user_path(order.user)
    end
    flash[:notice] = "Order number #{order.id} has been cancelled!"
  end

  def require_user
    render file: 'public/404', status: 404 unless current_user && current_user.default?
  end

end
