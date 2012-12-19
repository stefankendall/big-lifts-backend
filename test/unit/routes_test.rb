require 'test_helper'

class RoutesTest < ActionController::TestCase
  test "creating a user" do
    assert_routing({:path => 'users', :method => :post}, {:controller => 'users', :action => 'create'})
  end
end
