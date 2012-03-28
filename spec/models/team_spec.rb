require 'spec_helper'

describe Team do
  before(:each) do
    @valid_params = { name:           'Team 1',
                     description:     'user@email.com'}
  end
  
  it "should verify the presence of a name" do
      Team.create(@valid_params.merge(name: "")).should raise_error
  end
end