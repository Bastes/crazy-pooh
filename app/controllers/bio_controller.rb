class BioController < ApplicationController
  def index
    @resumes = Resume.all
  end
end
