class ItemsController < ApplicationController

  def index
    @merchants = Merchant.all
    @items = @items.active_items
  end

end
