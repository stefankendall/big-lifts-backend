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

      it "responds with 400" do
        post :create, attributes
        response.status.should == 400
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
end