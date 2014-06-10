require 'spec_helper'

describe "gametypes/edit" do
  before(:each) do
    @gametype = assign(:gametype, stub_model(Gametype,
      :name => "MyString",
      :number_of_teams => 1,
      :players_per_team => 1
    ))
  end

  it "renders the edit gametype form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", gametype_path(@gametype), "post" do
      assert_select "input#gametype_name[name=?]", "gametype[name]"
      assert_select "input#gametype_number_of_teams[name=?]", "gametype[number_of_teams]"
      assert_select "input#gametype_players_per_team[name=?]", "gametype[players_per_team]"
    end
  end
end
