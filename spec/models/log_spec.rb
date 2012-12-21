require 'spec_helper'

describe Log do
  it "should be addable to users" do
    user = FactoryGirl.create :user
    user.logs << Log.new(name: 'lift', weight: 400, sets: 5, reps: 3)
    user.save()

    user.logs.count().should == 1
  end
end
