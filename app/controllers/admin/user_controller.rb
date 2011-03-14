class Admin::UserController < Admin::ApplicationController
  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update_attributes(params[:user])
      flash[:notice] = t('notices.updated', :model => @user.class.model_name.human)
      redirect_to :action => :edit
    else
      render :action => :edit
    end
  end
end
