class Log < ActiveRecord::Base
  belongs_to :workout
  belongs_to :specific_workout, :polymorphic => true
  attr_accessible :date, :name, :notes, :reps, :sets, :weight, :workout
end
