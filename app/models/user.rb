class User < ActiveRecord::Base
  attr_accessible :username, :password

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true
end
