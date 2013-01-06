require_relative '../spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end

  it "prevents username duplication" do
    FactoryGirl.create(:user, username: 'ted').should be_valid
    FactoryGirl.build(:user, username: 'ted').should_not be_valid
  end

  it "hashes passwords on save" do
    user = FactoryGirl.create(:user, password: 'pass')
    user.authenticate('pass').should be_true
    user.authenticate('pass2').should be_false
  end
end