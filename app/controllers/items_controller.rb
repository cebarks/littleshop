class ItemsController < ApplicationController

  def index
    @merchants = Merchant.all
    @items = Item.all
  end

end
