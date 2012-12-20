class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_accessor :username, :password

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true
end
