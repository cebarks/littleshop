class SessionsController < ApplicationController
  def new
    if current_user
      flash[:notice] = "You are already logged in!"
      login_redirect(current_user.role)
    end
  end

  def create
    user = User.find_by(email: params[:user_email])
    if user.authenticate(params[:user_password])
      unless user.enabled?
        flash[:notice] = "Your account has been disabled by an administrator."
        render :new
        return
      end
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in!"
      login_redirect(user.role)
    else
      flash[:notice] = "Your credentials were incorrect!"
      render :new
    end
  end

  def login_redirect(role)
    redirect = {
      "default" => profile_path,
      "merchant" => dashboard_path,
      "admin" => root_path
    }
    redirect_to redirect[role]
  end

  def destroy
    session.clear
    flash[:notice] = "You are logged out!"
    redirect_to root_path
  end
end
