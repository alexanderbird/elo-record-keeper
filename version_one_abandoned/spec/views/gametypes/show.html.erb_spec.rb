require 'spec_helper'

describe "gametypes/show" do
  before(:each) do
    @gametype = assign(:gametype, stub_model(Gametype,
      :name => "Name",
      :number_of_teams => 1,
      :players_per_team => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
