class Admin::ExternalLinksController < Admin::ApplicationController
  def index
    @external_links = ExternalLink.all
  end

  def show
    @external_link = ExternalLink.find(params[:id])
  end

  def new
    @external_link = ExternalLink.new.tap { |external_link|
      external_link.section = params[:section] if params[:section]
    }
  end

  def edit
    @external_link = ExternalLink.find(params[:id])
  end

  def create
    if @external_link = ExternalLink.create(params[:external_link])
      flash[:notice] = t('notices.created', :model => @external_link.class.model_name.human)
      redirect_to [:admin, @external_link]
    else
      render :action => :new
    end
  end

  def update
    @external_link = ExternalLink.find(params[:id])
    if @external_link.update_attributes(params[:external_link])
      flash[:notice] = t('notices.updated', :model => @external_link.class.model_name.human)
      redirect_to [:admin, @external_link]
    else
      render :action => :edit
    end
  end

  def destroy
    ExternalLink.destroy(params[:id])
    redirect_to :action => :index
  end
end
