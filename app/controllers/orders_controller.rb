class OrdersController < ApplicationController

  def show
    if current_user && current_user.default?
      @order = Order.find(params[:order_id])
    else
      render file: 'public/404', status: 404
    end
  end

end
