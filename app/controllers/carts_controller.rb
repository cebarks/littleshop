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
    require_user_or_visitor
    @cart_contents = @cart.contents.values.sum
    @cart_items = @cart.all_items
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

  def checkout
    @cart.create_order(current_user)
    @cart.empty
    flash[:notice] = "Your order has been created! Thank you for your business!"
    redirect_to profile_path
  end

  private

  def require_user_or_visitor
    render file: 'public/404', status: 404 unless current_user.nil? || current_user.default?
  end
end
