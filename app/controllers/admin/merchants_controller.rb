class Admin::MerchantsController < ApplicationController
  def index
    @merchants = User.merchants
  end
end
