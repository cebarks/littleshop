class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:user_email])
    if user && user.authenticate(params[:user_password])
      session[:user_id] = user.id
      redirect_to profile_path
    else
      render :new
    end
  end
end
