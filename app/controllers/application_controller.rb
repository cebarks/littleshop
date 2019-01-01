class ApplicationController < ActionController::Base
  include ActionView::Helpers::TextHelper
  protect_from_forgery with: :exception

  before_action :build_cart

  helper_method :current_user

  def build_cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def not_found
    render 'public/404', status: 404
  end

end
