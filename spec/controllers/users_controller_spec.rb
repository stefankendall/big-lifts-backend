require_relative '../../spec/spec_helper'
require "rspec"

describe UsersController do
  describe "POST #create" do
    context "with username and password" do
      attributes = FactoryGirl.attributes_for(:user)

      it "responds with 201" do
        post :create, attributes
        response.status.should == 201
      end

      it "should return the username and password created in the create response" do
        post :create, attributes
        response_json = ActiveSupport::JSON.decode(response.body)
        response_json["user"]["username"] == attributes[:username]
        response_json["user"]["password"] == attributes[:password]
        response_json["user"]["id"].should == nil
      end
    end

    context "without username and password" do
      attributes = {}

      it "should generate a username is none is provided" do
        post :create, attributes
        response.status.should == 201
        ActiveSupport::JSON.decode(response.body)["user"]["username"].should_not == nil
        ActiveSupport::JSON.decode(response.body)["user"]["password"].should_not == nil
        ActiveSupport::JSON.decode(response.body)["user"]["password"].length.should == 8
      end
    end

    it "should create a default password if none is provided" do
      post :create, {username: Faker::Internet.user_name}
      response.status.should == 201
    end

    it "should block duplicate username creations" do
      attributes = FactoryGirl.attributes_for :user
      post :create, attributes
      response.status.should == 201

      post :create, attributes
      response.status.should == 400
      ActiveSupport::JSON.decode(response.body)["errors"]["username"][0].should == 'has already been taken'
    end
  end

  describe "PUT #update" do
    it "should prevent update with a bad password" do
      user = FactoryGirl.create(:user, password: 'pass')
      request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64.encode64(user.username + ":" + user.password + "bad")
      put :update, {:id => 1}

      response.status.should == 401
    end

    it "should return unprocessible entity if no username and password are provided" do
      user = FactoryGirl.create(:user, password: 'pass')
      request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64.encode64(user.username + ":" + user.password)
      put :update, {:id => 1}

      response.status.should == 400
    end

    it "should return OK with correct username and password, and update the password" do
      user = FactoryGirl.create(:user, password: 'pass')
      request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64.encode64(user.username + ":" + user.password)
      put :update, {:id => 1, :username => user.username, :password => '123'}

      response.status.should == 200
      user = User.find_by_username(user.username)
      ActiveSupport::JSON.decode(response.body)["status"].should == 'Password changed!'
      BCrypt::Password.new(user.password_digest).should == '123'
    end

    it "should change usernames when they are non-conflicting" do
      user1 = FactoryGirl.create(:user)
      new_username = FactoryGirl.attributes_for(:user)[:username]
      request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64.encode64(user1.username + ":" + user1.password)
      put :update, {:id => 1, :username => new_username, :password => user1.password}

      response.status.should == 200
      ActiveSupport::JSON.decode(response.body)["status"].should == 'Username changed!'
      user1.reload
      user1.username.should == new_username
    end

    it "should prevent bad password when trying to take over existing username" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64.encode64(user1.username + ":" + user1.password)
      put :update, {:id => 1, :username => user2.username, :password => 'blah'}

      response.status.should == 400
      ActiveSupport::JSON.decode(response.body)["status"].should == 'User exists, bad password'
    end

    it "should allow correct password when trying to take over existing username" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64.encode64(user1.username + ":" + user1.password)
      put :update, {:id => 1, :username => user2.username, :password => user2.password}

      response.status.should == 200
      ActiveSupport::JSON.decode(response.body)["status"].should == 'User recovered'
      User.count().should == 1
    end
  end
end