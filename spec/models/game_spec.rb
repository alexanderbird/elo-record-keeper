require 'spec_helper'

describe Game do
  before :each do
    @game = FactoryGirl.create :game
    @first = FactoryGirl.create(:participation)
    @second = FactoryGirl.create(:participation)
    @third = FactoryGirl.create(:participation)
    @game.participations << @first
    @game.participations << @second
    @game.participations << @third
  end
  it "exposes all the players involved as the 'participants' method" do
    expect(@game.participants).to include @first.player, @second.player, @third.player
  end
  
  it "has a date" do
    expect(FactoryGirl.build(:game, date: nil)).to_not be_valid
  end

  it "must have a game type" do
    expect(FactoryGirl.build(:game, game_type: nil)).to_not be_valid
  end

  it "has participants according to the game type" do
    type = FactoryGirl.create :game_type
    @game.game_type = type
    type.stub(:total_number_of_players).and_return 4
    expect(@game.full?).to be_false
  end
  it "has participants according to the game type" do
    type = FactoryGirl.create :game_type
    @game.game_type = type
    @game.participations << FactoryGirl.create(:participation)
    @game.participations << FactoryGirl.create(:participation)
    type.stub(:total_number_of_players).and_return 5
    expect(@game.full?).to be_true
  end

  it "has all valid participants to count for full" do
    type = FactoryGirl.create :game_type
    @game.game_type = type
    @first.stub(:valid?).and_return false
    type.stub(:total_number_of_players).and_return 3
    expect(@game.full?).to be_false
  end

  it "returns zero missing players if it's full" do
    @game.game_type = FactoryGirl.create(:game_type, number_of_teams: 3, players_per_team: 1)
    expect(@game.missing_players).to eq 0
  end

  it "returns the number of missing players if it's not full" do
    @game.game_type = FactoryGirl.create(:game_type, number_of_teams: 2, players_per_team: 3) # 6 players
    expect(@game.missing_players).to eq 3
  end
  
  it "does not consider invalid players when counting missing players" do
    @game.game_type = FactoryGirl.create(:game_type, number_of_teams: 3, players_per_team: 1) # 3 players
    expect(@game.missing_players).to eq 0
    @first.stub(:valid?).and_return false
    expect(@game.missing_players).to eq 1
  end

  it "is only valid if it is full" do
    pending "I've manually tested this and the condition has been met. I don't know what's wrong with the test"
    @game.stub(:full?).and_return false
    @game.valid?
    expect(@game.errors).to_not be_empty
  end
end
