class User < ActiveRecord::Base
  attr_accessible :username, :password

  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true

  def as_json(options = {})
    {
        username: self.username,
        password: self.password
    }
  end
end
