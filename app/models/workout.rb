class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :logs, :autosave => true, :dependent => :destroy

  default_scope includes(:logs)

  attr_accessible :workout_id, :logs, :name

  validates :workout_id, :presence => true
  validates :logs, :presence => true
  validates :name, :presence => true, :allow_blank => false

  def as_json(options={})
    json = super(options.merge(:include => {:logs => {:include => :specific_workout}}))
    json[:logs] = logs.collect { |log| log.as_json }
    json
  end
end
