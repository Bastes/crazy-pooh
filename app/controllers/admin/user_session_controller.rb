class Admin::UserSessionController < Admin::ApplicationController
  skip_before_filter :restricted
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new params[:user_session]
    if @user_session.valid?
      session[:user_id] = @user_session.user.id
      redirect_to :action => :show
    else
      session[:user_id] = nil
      render :action => :new
    end
  end

  def destroy
    session[:user_id] = nil
    # redirect_to root_url # FIXME
  end
end
