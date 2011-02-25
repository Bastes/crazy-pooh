class Admin::UserSessionController < Admin::ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new params[:user_session]
    if @user_session.valid?
      session[:user_session] = @user_session
      # redirect_to admin_url # FIXME
    else
      session[:user_session] = nil
      render :action => :new
    end
  end

  def destroy
    session[:user_session] = nil
    # redirect_to root_url # FIXME
  end
end
