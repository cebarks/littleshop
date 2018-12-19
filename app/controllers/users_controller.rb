class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if user_params[:confirm_password]
      flash[:notice] = "Your passwords didn't match!"
      redirect_to register_path
      return
    end

    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You have been registered and are now logged in!"
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      flash[:notice] = "An error occured!"
      redirect_to register_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = current_user
    render :show
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
