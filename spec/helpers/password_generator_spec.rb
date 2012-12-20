require 'spec_helper'

describe PasswordGenerator do
  it "generates 8 character passwords" do
    p = PasswordGenerator.generate
    p.length.should == 8
  end

  it "generates new passwords each invocation" do
    PasswordGenerator.generate.should_not == PasswordGenerator.generate
  end
end
