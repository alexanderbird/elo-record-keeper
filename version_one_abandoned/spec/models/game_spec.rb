require 'spec_helper'

describe Game do
  before :each do
    @bob = Player.create name: "bob"
    @jane = Player.create name: "Jane", rating: 1500
    @game = Game.new
  end
  it "registers participants" do
    @game.participants([@bob, @jane])
    expect(@game.results.to_a).to have(2).results
  end
  it "registers participants 2" do
    @game.participants([@bob, @jane])
    expect(@game.results.first.player).to eq @bob
  end
  it "registers participants 3" do
    @game.participants([@bob, @jane])
    expect(@game.results.last.player).to eq @jane
  end
  it "registers participants, setting result value to nil" do
    @game.participants([@bob, @jane])
    expect(@game.results.first.value).to be_nil
  end
  it "registers participants, setting result value to nil pt. 2" do
    @game.participants([@bob, @jane])
    expect(@game.results.last.value).to be_nil
  end
  it "registers scores when there are no participants" do
    @game.record(@bob, 1)
    @bob.reload
    expect(@bob.results.first.value).to eq 1
    expect(@bob.results.first.game).to eq @game
  end
  it "registers scores when there are no existing participants BUT records have been set" do
    @game.record(@jane, 1)
    @game.record(@bob, 1)
    @bob.reload
    expect(@bob.results.first.value).to eq 1
    expect(@bob.results.first.game).to eq @game
    expect(Result.count).to eq 2
  end
  it "registers scores for existing participants" do
    @game.participants([@bob, @jane])
    @game.record(@bob, 1)
    @bob.reload
    expect(Result.count).to eq 2
    expect(@bob.results.first.value).to eq 1
    expect(@bob.results.first.game).to eq @game
  end
  it "has methods for win" do
    @game.participants([@bob, @jane])
    @game.winner = @bob
    @bob.reload
    expect(@bob.results.first.value).to eq 1
    expect(@bob.results.first.game).to eq @game
  end
  it "also sets the loosers when the winner is set" do
    @game.participants([@bob, @jane])
    @game.winner = @bob
    @jane.reload
    expect(Result.count).to eq 2
    expect(@jane.results.first.value).to eq 0
    expect(@jane.results.first.game).to eq @game
  end
  it "has methods for lose" do
    @game.participants([@bob, @jane])
    @game.loser = @bob
    @bob.reload
    expect(@bob.results.first.value).to eq 0
    expect(@bob.results.first.game).to eq @game
  end
  it "also sets the winners when the loser is set" do
    @game.participants([@bob, @jane])
    @game.loser = @bob
    @jane.reload
    expect(Result.count).to eq 2
    expect(@jane.results.first.value).to eq 1
    expect(@jane.results.first.game).to eq @game
  end
  it "has method for draw that sets all results to 0.5" do
    @game.participants([@bob, @jane])
    @game.draw
    @jane.reload
    expect(@jane.results.first.value).to eq 0.5
    @bob.reload
    expect(@bob.results.first.value).to eq 0.5
  end
  it "updates every player's score when a result is registered" do
    pending
    @game.participants([@bob, @jane])
    @game.winner = @bob
    @bob.reload
    @jane.reload
    expect(@jane.rating).to eq 1476
    expect(@bob.rating).to eq 1023
  end
  it "updates every player's score when a result is registered pt 2" do
    pending
    @game.record(@bob, 1)
    @game.record(@jane, 0)
    @game.calculate
    @bob.reload
    @jane.reload
    expect(@jane.rating).to eq 1476
    expect(@bob.rating).to eq 1023
  end
  it "returns scoring incomplete if not all results have values" do
    [1,2,nil,4].each do |value|
      @game.results << Result.create(value: value)
    end
    expect(@game.scoring_complete?).to be_false
  end
  it "returns scoring complete if all results have values" do
    [1,2,3,4].each do |value|
      @game.results << Result.create(value: value)
    end
    expect(@game.scoring_complete?).to be_true
  end
  context "validations based on gametype" do
    it "must have a game type" do
      expect(Game.new(gametype: nil)).to_not be_valid
    end

  end

  it "works as the elo gem on which it is based advertizes" do
    pending "this integration test fails"
    bob  = Player.create
    jane = Player.create(:rating => 1500)
   
    print jane.inspect
    game1 = Game.new
    game1.record(bob, 1)
    game1.record(jane, 0)
    game1.calculate
    game2 = Game.new
    game2.record(bob, 0)
    game2.record(jane, 1)
    game2.calculate
    game3 = Game.new
    game3.record(bob, 0.5)
    game3.record(jane, 0.5)

    game4 = Game.new
    game4.record(bob, 0)
    game4.record(jane, 1)

    game5 = Game.new
    game5.record(bob, 1)
    game5.record(jane, 0)

    game6 = Game.new
    game6.participants([bob,jane])
    game6.draw

    game7 = Game.new
    game7.record(bob, 1)
    game7.record(jane, 0)

    game8 = Game.new
    game8.record(bob, 1)
    game8.record(jane, 0)

    binding.pry

    bob.rating.should == 1080
    jane.rating.should == 1412
    bob.should_not be_pro
    bob.should be_starter
    bob.games_played.should == 8
    bob.games.should == [ game1, game2, game3, game4, game5, game6, game7, game8 ]

    Player.all.should == [ bob, jane ]
    Game.all.should == [ game1, game2, game3, game4, game5, game6, game7, game8 ]

  end

end
