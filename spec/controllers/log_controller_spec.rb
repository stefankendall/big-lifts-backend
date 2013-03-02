require 'spec_helper'
require "rspec"

describe LogController do
  let(:user) { create_user() }

  before(:each) do
    request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64.encode64(user.username + ":" + user.password)
  end

  describe "POST #create" do
    it "will fail to save logs without an associated workout" do
      post :create
      response.status.should == 400
    end

    it "will fail to save logs without a specified user" do
      request.env['HTTP_AUTHORIZATION'] = nil
      post :create, {:workout_id => 1, :logs => [{sets: 5}]}
      response.status.should == 401
    end

    it "will not save workouts with an empty log set" do
      post :create, {:workout_id => 1}
      response.status.should == 400
    end

    it "will save workouts with an associated log" do
      post :create, {:workout_id => 1, :logs => [{sets: 5}]}
      response.status.should == 200
    end

    it "will default workouts without a name to 5/3/1" do
      post :create, {:workout_id => 1, :logs => [{sets: 5}]}
      response.status.should == 200
      get :index
      ActiveSupport::JSON.decode(response.body)[0]["name"].should == '5/3/1'
    end

    it "will save workouts with workout names" do
      post :create, {:workout_id => 1, :name => 'StartingStrength', :logs => [{sets: 5}]}
      get :index
      ActiveSupport::JSON.decode(response.body)[0]["name"].should == 'StartingStrength'
    end

    it "will save log dates in unix timestamps with an associated log" do
      timestamp = 141471717
      post :create, {:workout_id => 1, :logs => [{sets: 5, date: timestamp}]}
      response.status.should == 200

      get :index
      ActiveSupport::JSON.decode(response.body)[0]["logs"][0]['date'].should == timestamp
    end


    it "will save 5/3/1 workouts with 5/3/1 data" do
      post :create, {:workout_id => 1, :logs => [{sets: 5, specific: {type: '5/3/1', data: {cycle: 5}}}]}
      response.status.should == 200

      get :index

      log = ActiveSupport::JSON.decode(response.body)[0]["logs"][0]
      log['sets'].should == 5
      log['specific_workout']['cycle'].should == 5
    end

    it "will wipe existing logs for workout posts with same ids" do
      post :create, {:workout_id => 1, :logs => [{sets: 5, specific: {type: '5/3/1', data: {cycle: 5}}}]}
      post :create, {:workout_id => 1, :logs => [{sets: 2, specific: {type: '5/3/1', data: {cycle: 5}}}]}
      get :index
      ActiveSupport::JSON.decode(response.body).length.should == 1

      Workout.count().should == 1
    end
  end

  describe "GET #index" do
    it "returns all workouts for a user" do
      logs = [Log.create({:sets => 5, :reps => 3, name: "Press"}), Log.create({:sets => 5, :reps => 3, name: 'Power Clean'})]
      user.workouts() << Workout.create(workout_id: '1', logs: logs)

      get :index
      ActiveSupport::JSON.decode(response.body).length.should == 1
      ActiveSupport::JSON.decode(response.body)[0]["logs"].length.should == 2
    end
  end

  describe "DELETE #destroy" do
    it "should delete existing workouts by name" do
      post :create, {:workout_id => 1, :name => '5/3/1', :logs => [{sets: 5, specific: {type: '5/3/1', data: {cycle: 5}}}]}
      post :create, {:workout_id => 1, :name => 'StartingStrength', :logs => [{sets: 5, specific: {type: '5/3/1', data: {cycle: 5}}}]}
      delete :destroy, {:id => 1, :name => '5/3/1'}
      get :index
      ActiveSupport::JSON.decode(response.body).length.should == 1
    end
  end

  def create_user
    username = Faker::Internet.user_name
    password = Faker::Internet.user_name
    User.create(username: username, password: password)
  end
end
