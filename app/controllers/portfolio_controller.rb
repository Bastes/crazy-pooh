class PortfolioController < ApplicationController
  def index
    @achievements = Achievement.where(:section => params[:section]).all
    # bypasses the aplhabetical order of subsections when orderding years
    unless @achievements.any? { |a| a.subsection =~ /\A[^\d]/ }
      @achievements.sort! { |a, b|
        s = b.subsection <=> a.subsection
        s != 0 ? s : b.created_at <=> a.created_at }
    end
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

