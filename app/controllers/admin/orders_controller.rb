class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end
end
