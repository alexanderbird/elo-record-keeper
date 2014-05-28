require 'spec_helper'

describe Player do
  it "sets the pro_rating value by default" do
    Player.any_instance.stub(:pro_rating?).and_return false
    expect(Player.new.pro).to eq false
  end
  it "sets the pro_rating value by default" do
    Player.any_instance.stub(:pro_rating?).and_return true
    expect(Player.new.pro).to eq true
  end
end
