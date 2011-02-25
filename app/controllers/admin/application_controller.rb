class Admin::ApplicationController < ActionController::Base
  protect_from_forgery

  layout 'admin'

  protected

  def admin?
    session[:user_session] && session[:user_session].valid?
  end
  helper_method :admin?

  def user
    admin? && session[:user_session].user
  end

  def restricted
    redirect_to login_path unless admin?
  end
end
