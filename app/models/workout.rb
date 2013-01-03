class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :logs

  attr_accessible :local_workout_id
end
