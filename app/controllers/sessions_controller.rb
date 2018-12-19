class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:user_email])
    if user && user.authenticate(params[:user_password])
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

end
