class StaticContent < ActiveRecord::Base
  default_scope :order => 'codename ASC'

  validates :codename, :presence => true, :uniqueness => true

  attr_accessible :content
end
