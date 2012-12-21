require 'spec_helper'

describe PasswordGenerator do
  it "generates a new username" do
    UsernameGenerator.generate.should start_with "guest"
  end

  it "should end with numbers" do
    (UsernameGenerator.generate =~ /\d+$/).should_not == nil
  end
end
