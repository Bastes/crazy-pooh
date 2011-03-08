class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def admin?
    user && true
  end
  helper_method :admin?

  def user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :user
end
