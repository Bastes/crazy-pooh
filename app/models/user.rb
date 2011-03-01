class User < ActiveRecord::Base
  validates :login, :presence => true, :uniqueness => true, :length => { :minimum => 1 }
  validates :password, :presence => true, :length => { :minimum => 8 }
end
