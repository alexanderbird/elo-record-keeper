require 'spec_helper'

describe "players/edit" do
  before(:each) do
    @player = assign(:player, stub_model(Player,
      :name => "MyString",
      :pro => false,
      :rating => "9.99",
      :k_factor => "9.99"
    ))
  end

  it "renders the edit player form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", player_path(@player), "post" do
      assert_select "input#player_name[name=?]", "player[name]"
      assert_select "input#player_pro[name=?]", "player[pro]"
      assert_select "input#player_rating[name=?]", "player[rating]"
      assert_select "input#player_k_factor[name=?]", "player[k_factor]"
    end
  end
end
