class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user_id
      redirect_to profile_path
    else
      render :new
    end
  end
end
