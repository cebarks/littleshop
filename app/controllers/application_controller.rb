class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :build_cart

  helper_method :current_user
  helper_method :current_merchant
  helper_method :current_admin


  def build_cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_merchant
    @current_merchant ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin
    @current_admin ||= User.find(session[:user_id]) if session[:user_id]
  end
end
