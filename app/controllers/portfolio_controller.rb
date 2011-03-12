class PortfolioController < ApplicationController
  def index
    @achievements = Achievement.where(:section => params[:section]).all
    render 'index_and_show'
  end

  def show
    @achievement = Achievement.
      where(:section => params[:section]).
      where(:subsection => params[:subsection]).
      where(:title => params[:title]).
      first
    render 'index_and_show'
  end
end

