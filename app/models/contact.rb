class Contact < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :reason
  validates :email,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
end
