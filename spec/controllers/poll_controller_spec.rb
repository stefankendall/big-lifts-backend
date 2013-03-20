require 'spec_helper'

describe PollController do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64.encode64(user.username + ":" + user.password)
  end

  it "should fail if a name is not provided for the poll" do
    post :poll, {:answer => 'true'}
    response.status.should == 400
  end

  it "should create a subscription poll record for the user subscribing" do
    post :poll, {:name => 'subscribe', :answer => 'true'}
    poll = Poll.find_all_by_name('subscribe')
    poll.length.should == 1
    Poll.find_by_name('subscribe').answer.should be_true
  end

  it "should honor poll subscribe answer, false" do
    post :poll, {:name => 'subscribe', :answer => 'false'}
    Poll.find_by_name('subscribe').answer.should be_false
  end
end
