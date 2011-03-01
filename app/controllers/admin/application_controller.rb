class Admin::ApplicationController < ActionController::Base
  protect_from_forgery

  layout 'admin'

  before_filter :restricted

  protected

  def admin?
    user && true
  end
  helper_method :admin?

  def user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :user

  def restricted
    Rails.logger.debug "session: #{session.inspect}"
    head :forbidden unless admin?
  end
end
