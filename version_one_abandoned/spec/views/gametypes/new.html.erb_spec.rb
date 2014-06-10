require 'spec_helper'

describe "gametypes/new" do
  before(:each) do
    assign(:gametype, stub_model(Gametype,
      :name => "MyString",
      :number_of_teams => 1,
      :players_per_team => 1
    ).as_new_record)
  end

  it "renders new gametype form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", gametypes_path, "post" do
      assert_select "input#gametype_name[name=?]", "gametype[name]"
      assert_select "input#gametype_number_of_teams[name=?]", "gametype[number_of_teams]"
      assert_select "input#gametype_players_per_team[name=?]", "gametype[players_per_team]"
    end
  end
end
