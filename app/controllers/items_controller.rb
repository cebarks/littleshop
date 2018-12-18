class ItemsController < ApplicationController

  def index
    @merchants = User.merchants
  end

  def show
    @item = Item.find(params[:id])
  end
end
