class Admin::UsersController < ApplicationController

  def index
    @users = User.default_users
  end

  def show
    @merchants = User.merchants
  end
end
