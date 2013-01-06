require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :username, :password
  has_many :workouts

  validates :username, :presence => true, :uniqueness => true
  validates :password_digest, :presence => true

  def as_json(options = {})
    {
        username: self.username,
        password: self.password
    }
  end
end
