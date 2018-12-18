class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    render :new if user_params[:confirm_password]

    if @user.save
      redirect_to profile_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  private

  def user_params
    parms = params.require(:user).permit(:email, :password, :confirm_password, :name, :address, :city, :state, :zipcode)
    if parms[:password] == parms[:confirm_password]
      parms.delete(:confirm_password)
    end
    parms
  end
end
