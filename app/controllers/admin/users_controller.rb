class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.default_users
  end

  def show
    @user = User.find(params[:id])

    if @user.merchant?
      redirect_to admin_merchant_path(@user)
    else
      render "users/show"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "#{@user.name}'s account has been changed."
      redirect_to admin_user_path(@user)
    else
      flash[:notice] = "You have entered invalid changes. Please try again."
      redirect_to edit_admin_user_path(@user)
    end
  end

  def disable
    user = User.find(params[:id])
    user.status = false
    user.save
    flash[:notice] = "#{user.name}'s account has been disabled!"
    redirect_to admin_users_path
  end

  def enable
    user = User.find(params[:id])
    user.status = true
    user.save
    flash[:notice] = "#{user.name}'s account has been enabled!"
    redirect_to admin_users_path
  end

  private

  def require_admin
    render file: 'public/404', status: 404 unless current_user && current_user.admin?
  end

  def user_params
    params.require(:user).permit(:status, :email, :name, :address, :city, :state, :zipcode)
  end

end
