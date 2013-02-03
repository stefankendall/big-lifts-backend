class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :logs, :autosave => true, :dependent => :destroy

  attr_accessible :workout_id, :logs

  validates :workout_id, :presence => true
  validates :logs, :presence => true

  def as_json(options={})
    super(options.merge(:include => {:logs => {:include => :specific_workout}}))
  end
end
