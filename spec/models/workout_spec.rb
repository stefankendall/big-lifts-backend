require 'spec_helper'

describe Log do
  it "should fully serialize logs" do
    log = FactoryGirl.build :log, :specific_workout => FactoryGirl.build(:w531)
    workout = FactoryGirl.build :workout, :user => FactoryGirl.build(:user), :logs => [log]

    json = ActiveSupport::JSON.decode(workout.to_json)
    json['logs'][0]['specific_workout'].should_not be_nil
  end
end
