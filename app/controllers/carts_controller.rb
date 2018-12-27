class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    count = @cart.amount(item.id)
    flash[:success] = "You now have #{"#{pluralize(count, "glass")}"} of #{item.name} in your cart."
    redirect_to items_path
  end

  def show
    @cart_contents = @cart.total_count
  end
end
