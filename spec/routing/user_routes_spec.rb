require 'spec_helper'

describe UsersController do
  it "should recognize the create user path" do
    assert_routing({:path => 'users', :method => :post}, {:controller => 'users', :action => 'create'})
  end
end
