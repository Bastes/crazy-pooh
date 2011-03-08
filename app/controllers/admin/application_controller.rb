class Admin::ApplicationController < ApplicationController
  layout 'admin'

  before_filter :restricted

  protected

  def restricted
    Rails.logger.debug "session: #{session.inspect}"
    head :forbidden unless admin?
  end
end
