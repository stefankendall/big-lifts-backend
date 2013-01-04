require 'spec_helper'

describe LogController do
  it "should recognize the create log path" do
    assert_routing({:path => 'log', :method => :post}, {:controller => 'log', :action => 'create'})
  end

  it "should recognize the get log path" do
    assert_routing({:path => '/log/123', :method => :get}, {:controller => 'log', :action => 'show', :id => '123'})
  end

  it "should recognize the update log path" do
    assert_routing({:path => '/log/123', :method => :put}, {:controller => 'log', :action => 'update', :id => '123'})
  end
end
