class Admin::MerchantsController < ApplicationController
  def index
    unless current_user.admin?
      render file: 'public/404', status: 404
    else
      @merchants = User.merchants
    end
  end

  def show
    if current_user.admin?
      @merchant = User.find(params[:id])
      redirect_to admin_user_path(@merchant) if @merchant.default?
    else
      render file: 'public/404', status: 404
    end
  end

  def update
    user = User.find(params[:id])
    return not_found unless current_user.admin?
    if params[:role] && params[:role] == 'user'
      user.role = 'default'
      user.save
      flash[:notice] = "#{user.email} has been downgraded to default user status."

      return redirect_to admin_user_path(user)
    else
      user.toggle_status
      user.save

      flash[:notice] = if user.status
        "#{user.name}'s account has been enabled!"
      else
        "#{user.name}'s account has been disabled!"
      end
    end

    if user && user.merchant?
      redirect_to admin_merchants_path
    else
      redirect_to admin_users_path
    end
  end
end
