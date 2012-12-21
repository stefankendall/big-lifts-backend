class Log < ActiveRecord::Base
  belongs_to :user
  attr_accessible :cycle, :date, :expected_reps, :name, :notes, :reps, :sets, :week, :weight
end
