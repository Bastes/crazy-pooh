class ExternalLinksController < ApplicationController
  def index
    @external_links = ExternalLink.all
  end
end

