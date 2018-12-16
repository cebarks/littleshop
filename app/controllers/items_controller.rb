class ItemsController < ApplicationController

  def index
    @merchants = Merchant.all
    @items = Item.active_items
  end

end
