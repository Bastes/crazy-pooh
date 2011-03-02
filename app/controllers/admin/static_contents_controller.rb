class Admin::StaticContentsController < Admin::ApplicationController
  def index
    @static_contents = StaticContent.all
  end

  def edit
    @static_content = StaticContent.find(params[:id])
  end

  def update
    @static_content = StaticContent.find(params[:id])
    if @static_content.update_attributes(params[:static_content])
      flash[:notice] = t('notices.updated', :model => @static_content.class.human_name)
      redirect_to :action => :edit
    else
      render :action => :edit
    end
  end
end