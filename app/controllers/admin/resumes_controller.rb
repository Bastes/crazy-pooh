class Admin::ResumesController < Admin::ApplicationController
  def index
    @resumes = Resume.all
  end

  def show
    @resume = Resume.find(params[:id])
  end

  def new
    @resume = Resume.new
  end

  def edit
    @resume = Resume.find(params[:id])
  end

  def create
    @resume = Resume.create(params[:resume])
    if @resume.save
      flash[:notice] = t('notices.created', :model => @resume.class.model_name.human)
      redirect_to [:admin, @resume]
    else
      render :action => :new, :status => :unprocessable_entity
    end
  end

  def update
    @resume = Resume.find(params[:id])
    if @resume.update_attributes(params[:resume])
      flash[:notice] = t('notices.updated', :model => @resume.class.model_name.human)
      redirect_to :action => :edit
    else
      render :action => :edit, :status => :unprocessable_entity
    end
  end

  def destroy
    Resume.destroy(params[:id])
    redirect_to :action => :index
  end
end
