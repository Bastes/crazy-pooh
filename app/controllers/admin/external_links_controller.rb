class Admin::ExternalLinksController < Admin::ApplicationController
  def index
    @external_links = ExternalLink.all
  end

  def new
    @external_link = ExternalLink.new
  end

  def edit
    @external_link = ExternalLink.find(params[:id])
  end

  def create
    if @external_link = ExternalLink.create(params[:external_link])
      flash[:notice] = t('notices.created', :model => @external_link.class.human_name)
      redirect_to [:edit, :admin, @external_link]
    else
      render :action => :new
    end
  end

  def update
    @external_link = ExternalLink.find(params[:id])
    if @external_link.update_attributes(params[:external_link])
      flash[:notice] = t('notices.updated', :model => @external_link.class.human_name)
      redirect_to :action => :edit
    else
      render :action => :edit
    end
  end

  def destroy
    ExternalLink.destroy(params[:id])
    redirect_to :action => :index
  end
end
