require 'spec_helper'

describe LogController do
  describe "POST #create" do
    it "will fail to save logs without an associated workout" do
      post :create, {}
      response.status.should == 400
    end

    it "will not save workouts with an empty log set" do
      post :create, {:workout_id => '1'}
      response.status.should == 400
    end

    it "will save workouts with an associated log" do
      post :create, {:workout_id => '1', :logs => [{sets: 5}]}
      response.status.should == 200
    end
  end

  describe "GET #index" do
    it "returns all workouts for a user" do
      username = Faker::Internet.user_name
      password = Faker::Internet.user_name
      user = User.create(username: username, password: password)
      logs = [Log.create({:sets => 5, :reps => 3, name: "Press"}), Log.create({:sets => 5, :reps => 3, name: 'Power Clean'})]
      user.workouts() << Workout.create(local_workout_id: '1', logs: logs)

      get :index, {:username => username, :password => password}
      ActiveSupport::JSON.decode(response.body).length.should == 1
      ActiveSupport::JSON.decode(response.body)[0]["logs"].length.should == 2
    end
  end
end
