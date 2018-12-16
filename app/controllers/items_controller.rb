class ItemsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

end
