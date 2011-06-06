class ContactsController < ApplicationController
  before_filter :new_contact, :only => [:index, :new]

  def index
  end

  def new
  end

  def create
    @contact = Contact.new params[:contact]
    if @contact.save
      flash[:notice] = t('contact_posted')
      ContactMailer.contact_request(@contact).deliver
      redirect_to :action => :index
    else
      render :action => :new, :status => 400
    end
  end

  private
  
  def new_contact
    @contact = Contact.new
  end
end
