require 'spec_helper'

describe LogController do
  describe "POST #create" do
    it "will fail to save logs without an associated workout" do
      post :create, {}
      response.status.should == 400
    end

    it "will not save logs with an empty log set" do
      post :create, {:local_workout_id => '1'}
      response.status.should == 400
    end

    it "will save logs with an associated workout" do
      post :create, {:local_workout_id => '1', :logs => [{sets: 5}]}
      response.status.should == 200
    end
  end

  describe "GET #show " do
  end
end
