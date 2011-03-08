class Admin::ApplicationController < ApplicationController
  layout 'admin'

  before_filter :restricted

  protected

  def restricted
    head :forbidden unless admin?
  end
end
