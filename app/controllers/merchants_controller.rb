class MerchantsController < ApplicationController

  def index
    @merchants = User.merchants
  end
end
