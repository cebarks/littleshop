class ItemsController < ApplicationController

  def index
    @merchants = User.merchants
    @items = Item.all
  end

  def show
  end
  
end
