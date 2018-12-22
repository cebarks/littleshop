class Admin::UsersController < ApplicationController

  def index
    @users = User.default_users
  end

  def show
    @merchants = User.merchants
  end

  def update
    user = User.find(params[:id])
    user.toggle_status(user)
    binding.pry
  end

  private

  def user_params_admin
    params.require(:user).permit(:status)
  end

end
