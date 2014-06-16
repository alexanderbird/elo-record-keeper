require 'spec_helper'

describe GameType do
  it "must have a name" do
    expect(FactoryGirl.build(:game_type, name: nil)).to_not be_valid
  end
  
  it "must have a value for number_of_teams" do
    expect(FactoryGirl.build(:game_type, number_of_teams: nil)).to_not be_valid
  end

  it "must have at least two teams" do
    expect(FactoryGirl.build(:game_type, number_of_teams: 1)).to_not be_valid
  end

  it "must have a value for players_per_team" do
    expect(FactoryGirl.build(:game_type, players_per_team: nil)).to_not be_valid
  end

  it "must have at least one player per team" do
    expect(FactoryGirl.build(:game_type, players_per_team: 0)).to_not be_valid
  end

  it "is valid if it has a name, players per team, and a number of teams" do
    expect(GameType.new(name: "Awesome Type", number_of_teams: 2, players_per_team: 1)).to be_valid
  end

  it "is valid with large team and player numbers" do
    expect(FactoryGirl.build(:game_type, number_of_teams: 500, players_per_team: 600)).to be_valid
  end

  it "gives the number or players needed to play" do
    expect(FactoryGirl.build(:game_type, number_of_teams: 4, players_per_team: 3).total_number_of_players).to eq 12
  end
  it "gives the number or players needed to play" do
    expect(FactoryGirl.build(:game_type, number_of_teams: 2, players_per_team: 5).total_number_of_players).to eq 10
  end
  it "gives the number or players needed to play" do
    expect(FactoryGirl.build(:game_type, number_of_teams: 2, players_per_team: 1).total_number_of_players).to eq 2
  end
end
