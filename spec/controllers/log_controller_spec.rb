require 'spec_helper'

describe LogController do
  let(:user) { create_user() }
  let(:auth) { {:username => user.username, :password => user.password} }

  describe "POST #create" do
    it "will fail to save logs without an associated workout" do
      post :create, auth
      response.status.should == 400
    end

    it "will fail to save logs without a specified user" do
      post :create, {:workout_id => '1', :logs => [{sets: 5}]}
      response.status.should == 401
    end

    it "will not save workouts with an empty log set" do
      post :create, {:workout_id => '1'}.merge(auth)
      response.status.should == 400
    end

    it "will save workouts with an associated log" do
      post :create, {:workout_id => '1', :logs => [{sets: 5}]}.merge(auth)
      response.status.should == 200
    end
  end

  describe "PUT #update" do
    it "will update existing logs" do
      post :create, {:workout_id => '1', :logs => [{sets: 5}]}.merge(auth)
      put :update, {:id => '1', :workout_id => '1', :logs => [{sets: 6}, {reps: 5}]}.merge(auth)
      get :index, auth
      ActiveSupport::JSON.decode(response.body).length.should == 1
      ActiveSupport::JSON.decode(response.body)[0]["logs"].length.should == 2
      Log.count().should == 2
    end
  end

  describe "GET #index" do
    it "returns all workouts for a user" do
      logs = [Log.create({:sets => 5, :reps => 3, name: "Press"}), Log.create({:sets => 5, :reps => 3, name: 'Power Clean'})]
      user.workouts() << Workout.create(local_workout_id: '1', logs: logs)

      get :index, auth
      ActiveSupport::JSON.decode(response.body).length.should == 1
      ActiveSupport::JSON.decode(response.body)[0]["logs"].length.should == 2
    end
  end

  def create_user
    username = Faker::Internet.user_name
    password = Faker::Internet.user_name
    User.create(username: username, password: password)
  end
end
