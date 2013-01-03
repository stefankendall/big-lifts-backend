class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :logs, :autosave => true

  attr_accessible :local_workout_id

  validates :local_workout_id, :presence => true
  validates :logs, :presence => true
end
