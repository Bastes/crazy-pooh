class Admin::AchievementsController < Admin::ApplicationController
  def index
    @achievements = Achievement.all
  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  def new
    @achievement = Achievement.new.tap do |achievement|
      achievement.section = params[:section] if params[:section]
      achievement.subsection = params[:subsection] if params[:subsection]
    end
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def create
    @achievement = Achievement.new.tap { |achievement|
      %w{x y w h}.each { |k| # paperclip clipping processor fix
        key = "crop_#{k}"
        achievement.send("#{key}=".to_sym, params[:achievement][key.to_sym]) }
      achievement.attributes = params[:achievement] }
    if @achievement.save
      flash[:notice] = t('notices.created', :model => @achievement.class.model_name.human)
      redirect_to [:admin, @achievement]
    else
      render :action => :new, :status => :unprocessable_entity
    end
  end

  def update
    @achievement = Achievement.find(params[:id])
    if @achievement.update_attributes(params[:achievement])
      flash[:notice] = t('notices.updated', :model => @achievement.class.model_name.human)
      redirect_to [:admin, @achievement]
    else
      render :action => :edit, :status => :unprocessable_entity
    end
  end

  def destroy
    Achievement.destroy(params[:id])
    redirect_to :action => :index
  end
end
