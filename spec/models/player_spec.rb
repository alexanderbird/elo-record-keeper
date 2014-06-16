require 'spec_helper'

describe Player do
  it "must have a name" do
    expect(FactoryGirl.build(:player, name: nil)).to_not be_valid
  end
  it "must have a unique name" do
    FactoryGirl.create :player, name: "This One's Taken"
    expect(FactoryGirl.build(:player, name: "This One's Taken")).to_not be_valid
  end
  it "has a default rating of 1500" do
    player = Player.new name: "New Guy", rating: nil 
    expect(player.rating).to eq 1500
  end
  it "is valid if it has a unique name and a rating" do
    expect(Player.new(name: "New Guy", rating: 1200)).to be_valid
  end
end
