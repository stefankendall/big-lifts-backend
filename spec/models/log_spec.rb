require 'spec_helper'

describe Log do
  it "should be addable to workouts" do
    workout = FactoryGirl.build :workout, :user => FactoryGirl.build(:user)
    workout.logs << Log.new(name: 'lift', weight: 400, sets: 5, reps: 3)
    workout.save()

    workout.logs.count().should == 1
  end

  it "should be able to retrieve specific workouts" do
    log = FactoryGirl.build :log
    w531workout = FactoryGirl.build :w531
    log.specific_workout = w531workout
    log.save!

    log.errors.should be_empty
    log.specific_workout.should_not be_nil
  end
end
