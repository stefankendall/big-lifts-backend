class Log < ActiveRecord::Base
  belongs_to :workout
  belongs_to :specific_workout, :polymorphic => true
  attr_accessible :date, :name, :notes, :reps, :sets, :weight, :workout, :units

  def as_json(options={})
    json = super(options.merge(:include => [:specific_workout]))
    json['date'] = date.to_i
    json
  end
end
