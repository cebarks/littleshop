class UsersController < ApplicationController
  def index
    @orders = Order.all
    @merchants_for_stats = User.enabled_merchants
    @top_3_states = User.top_3_states_by_order_count
    @top_3_cities = User.top_3_cities_by_order_count
    @merchants = if current_user && current_user.admin?
      User.merchants
    else
      User.enabled_merchants
    end
  end

  def new
    @user = User.new
  end

  def create
    unless password_match
      redirect_to register_path
      return
    end

    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You have been registered and are now logged in!"
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      flash[:notice] = unless @user.errors.messages[:email].empty?
        "This email is already in use!"
      else
        "You were missing required fields!"
      end
      render :new
    end
  end

  def show
    if current_user
      @user = current_user
      @user.reload
    else
      render file: 'public/404', status: 404
    end
  end

  def edit
    if current_user
      @user = current_user
    else
      render file: 'public/404', status: 404
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated!"
      redirect_to profile_path
    else
      flash[:notice] = unless @user.errors.messages[:email].empty?
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

  def password_match
    match = params[:user][:password] == params[:user][:confirm_password]
    flash[:notice] = "Your passwords didn't match!" unless match
    match
  end
end
