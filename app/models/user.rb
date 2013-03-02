require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :username, :password
  has_many :workouts, :dependent => :destroy

  validates :username, :presence => true, :uniqueness => true
  validates :password_digest, :presence => true

  validate :no_duplicate_workouts

  def as_json(options = {})
    {
        username: self.username,
        password: self.password
    }
  end

  def delete_workout_by_id_and_name(workout_id, name)
    self.workouts().select { |w| w.workout_id == workout_id && w.name == name }.each do |existing|
      self.workouts().delete existing
    end
  end

  private
  def no_duplicate_workouts
    workout_ids = self.workouts().collect { |w| "#{w.workout_id}#{w.name}" }
    if workout_ids.length > 0 and workout_ids.length != workout_ids.uniq.length
      errors.add(:workouts, "Duplicate workout ids")
    end
  end
end
