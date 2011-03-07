class Admin::AchievementsController < Admin::ApplicationController
  def index
    @achievements = Achievement.all
  end

  def new
    @achievement = Achievement.new
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def create
    if @achievement = Achievement.create(params[:achievement])
      flash[:notice] = t('notices.created', :model => @achievement.class.human_name)
      redirect_to [:edit, :admin, @achievement]
    else
      render :action => :new
    end
  end

  def update
    @achievement = Achievement.find(params[:id])
    if @achievement.update_attributes(params[:achievement])
      flash[:notice] = t('notices.updated', :model => @achievement.class.human_name)
      redirect_to :action => :edit
    else
      render :action => :edit
    end
  end

  def destroy
    Achievement.destroy(params[:id])
    redirect_to :action => :index
  end
end
