class Admin::MerchantsController < ApplicationController
  def index
    @merchants = User.merchants
  end

  def show
    @merchant = User.find(params[:id])
    redirect_to admin_user_path(@merchant) if @merchant.default?
  end

  def update
    user = User.find(params[:id])
    user.toggle_status
    user.save
    flash[:notice] = if user.status
       "#{user.name}'s account has been enabled!"
    else
      "#{user.name}'s account has been disabled!"
    end
    if params[:redirect] && params[:redirect].eql?("merch_index")
      redirect_to admin_merchants_path
    else
      redirect_to admin_users_path
    end
  end

end
