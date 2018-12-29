class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    item = Item.find(params[:item])
    @cart.add_item(item)
    session[:cart] = @cart.contents
    count = @cart.item_amount(item)
    flash[:success] = "You now have #{"#{pluralize(count, "glass")}"} of #{item.name} in your cart."
    redirect_to items_path
  end

  def show
    if current_user.nil? || current_user.default?
      @cart_contents = @cart.contents.values.sum
      @cart_items = @cart.all_items
    else
      render file: 'public/404', status: 404
    end
  end

  def update
    if params[:item_change] == "remove"
      @cart.remove_item(params[:item_id])
    elsif
      params[:item_change] == "add"
      @cart.increase_item_count(params[:item_id])
    elsif
      params[:item_change] == "decrease"
      @cart.decrease_item_count(params[:item_id])
    end
    redirect_to cart_path
  end

  def destroy
    session[:cart] = {}
    @cart.empty
    redirect_to cart_path
  end

end
