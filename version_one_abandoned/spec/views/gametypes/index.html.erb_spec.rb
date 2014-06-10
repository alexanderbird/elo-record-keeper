require 'spec_helper'

describe "gametypes/index" do
  before(:each) do
    assign(:gametypes, [
      stub_model(Gametype,
        :name => "Name",
        :number_of_teams => 1,
        :players_per_team => 2
      ),
      stub_model(Gametype,
        :name => "Name",
        :number_of_teams => 1,
        :players_per_team => 2
      )
    ])
  end

  it "renders a list of gametypes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
