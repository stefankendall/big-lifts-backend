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
    end

    context "without username and password" do
      attributes = {}

      it "responds with 400" do
        post :create, attributes
        response.status.should == 400
      end
    end
  end
end