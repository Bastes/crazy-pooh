class SitemapController < ApplicationController
  def show
    @achievements = Achievements.order('section ASC, subsection ASC').all
  end
end
