require 'spec_helper'

describe Participation do
  context "validations" do
    # the participation object must have a valid player, but does not require a valid
    # game. This is because the player belongs to the game, and the game owns the par-
    # ticipation. The game is responsible for checking that there are the right number
    # of participants, etc.
    it "is_not valid if tehre is no player" do
      expect(FactoryGirl.build(:participation, player: nil)).to_not be_valid
    end
    it "is valid with a player" do
      player = FactoryGirl.create :player
      expect(FactoryGirl.build(:participation, player: player)).to be_valid
    end
    it "is not valid if the player isn't valid" do
      invalid_player = FactoryGirl.create :player
      Player.any_instance.stub(:valid?).and_return false
      expect(FactoryGirl.build(:participation, player: invalid_player)).to_not be_valid
    end
    it "is valid without a game" do
      expect(FactoryGirl.build(:participation, game: nil)).to be_valid
    end
    it "is valid if the game isn't valid" do
      invalid_game = FactoryGirl.create :game
      Game.any_instance.stub(:valid?).and_return false
      expect(FactoryGirl.build(:participation, game: invalid_game)).to be_valid
    end
    it "must have a score" do
      expect(FactoryGirl.build(:participation, score: nil)).to_not be_valid
    end
    it "must have a team number" do
      expect(FactoryGirl.build(:participation, team_number: nil)).to_not be_valid
    end
  end
end
