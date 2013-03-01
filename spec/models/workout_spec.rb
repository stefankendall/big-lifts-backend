require 'spec_helper'

describe Workout do
  it "should fully serialize logs" do
    log = FactoryGirl.build :log, :specific_workout => FactoryGirl.build(:w531)
    workout = FactoryGirl.build :workout, :user => FactoryGirl.build(:user), :logs => [log]

    json = ActiveSupport::JSON.decode(workout.to_json)
    json['logs'][0]['specific_workout'].should_not be_nil
  end

  it "should serialize log dates as timestamps" do
    timestamp = 1231051091
    log = FactoryGirl.build :log, :date => Time.at(timestamp)
    workout = FactoryGirl.build :workout, :user => FactoryGirl.build(:user), :logs => [log]

    json = ActiveSupport::JSON.decode(workout.to_json)
    json['logs'][0]['date'].should == timestamp
  end

  it "should prevent blank types" do
    workout = FactoryGirl.build :workout, :name => ''
    workout.should_not be_valid
  end
end
