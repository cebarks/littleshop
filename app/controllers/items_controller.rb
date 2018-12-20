class ItemsController < ApplicationController

  def index
    @merchants = User.merchants
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

end
