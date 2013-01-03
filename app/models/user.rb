require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :username, :password
  has_many :workouts

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true

  before_save :hash_password, :if => :password_changed?

  def as_json(options = {})
    {
        username: self.username,
        password: self.password
    }
  end

  private
  def hash_password
    self.password = BCrypt::Password.create(self.password)
  end
end
