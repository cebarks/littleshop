class ItemsController < ApplicationController

  def index
    @merchants = User.merchants
  end

  def show
  end
end
