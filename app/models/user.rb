class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_accessor :username, :password

  validates :username, :presence => true
  validates :password, :presence => true
end
