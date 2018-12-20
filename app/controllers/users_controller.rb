class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    unless params[:user][:password] == params[:user][:confirm_password]
      flash[:notice] = "Your passwords didn't match!"
      redirect_to register_path
      return
    end

    @user = User.new(user_params)

    if User.where(email: user_params[:email]).length != 0
      flash[:notice] = "This email is already in use!"
      render :new
      return
    end

    if @user.save
      flash[:notice] = "You have been registered and are now logged in!"
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      flash[:notice] = "You were missing required fields!"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = current_user
    @user.reload
    render :show
  end

  def edit_profile
    @user = current_user
    render :edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated!"
      redirect_to profile_path
    else
      flash[:notice] = if @user.errors.messages[:email]
        "This email is already in use!"
      else
        "You entered invalid changes!"
      end
      redirect_to profile_edit_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name, :address, :city, :state, :zipcode)
  end

end
