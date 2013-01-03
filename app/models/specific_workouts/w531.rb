class W531 < ActiveRecord::Base
  has_one :log, :as => :specific_workout
  attr_accessible :cycle, :expected_reps, :week
end
