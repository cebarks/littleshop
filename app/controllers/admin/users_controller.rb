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
    user.save
    flash[:notice] = if user.status
       "#{user.name}'s account has been enabled!"
    else
      "#{user.name}'s account has been disabled!"
    end
    redirect_to admin_users_path
  end

  private

  def user_params_admin
    params.require(:user).permit(:status)
  end

end
