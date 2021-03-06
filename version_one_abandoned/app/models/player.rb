class Player < ActiveRecord::Base
  has_many :results
  has_many :games, through: :results
  after_initialize :set_defaults
  def set_defaults
    if self.new_record?
      self.pro ||= self.pro_rating?
      # The rating you provided, or the default rating from configuration
      self.rating ||= Elo.config.default_rating
      self.k_factor ||= depracated_k_factor
    end
  end

  def safe_rating
    # The rating you provided, or the default rating from configuration
    self.rating ||= Elo.config.default_rating
  end

  # The number of games played is needed for calculating the K-factor.
  def games_played
    self.results.to_a.count
  end

  # A list of games played by the player.
  def games
    self.results.map {|r|;r.game}
  end

  # Is the player considered a pro, because his/her rating crossed
  # the threshold configured? This is needed for calculating the K-factor.
  def pro_rating?
    safe_rating >= Elo.config.pro_rating_boundry
  end

  # Is the player just starting? Provide the boundry for
  # the amount of games played in the configuration.
  # This is needed for calculating the K-factor.
  def starter?
    games_played < Elo.config.starter_boundry
  end

  # FIDE regulations specify that once you reach a pro status
  # (see +pro_rating?+), you are considered a pro for life.
  #
  # You might need to specify it manually, when depending on
  # external persistence of players.
  #
  #		Elo::Player.new(:pro => true)
  def pro?
    !!self.pro
  end

  # Calculates the K-factor for the player.
  # Elo allows you specify custom Rules (see Elo::Configuration).
  #
  # You can set it manually, if you wish:
  #
  #		Elo::Player.new(:k_factor => 10)
  #
  #	This stops this player from using the K-factor rules.
  def depracated_k_factor
    #return self.k_factor if self.k_factor
    Elo.config.applied_k_factors.each do |rule|
      return rule[:factor] if instance_eval(&rule[:rule])
    end
    Elo.config.default_k_factor
  end

  # Start a game with another player. At this point, no
  # result is known and nothing really happens.
  def versus(other_player, options = {})
    game = Game.new
    game.players << self
    game.players << other_player
    game.calculate
  end

  # Start a game with another player and set the score
  # immediately.
  def wins_from(other_player, options = {})
    versus(other_player, options).win
  end

  # Start a game with another player and set the score
  # immediately.
  def plays_draw(other_player, options = {})
    versus(other_player, options).draw
  end

  # Start a game with another player and set the score
  # immediately.
  def loses_from(other_player, options = {})
    versus(other_player, options).lose
  end

  private

  # A Game tells the players informed to update their
  # scores, after it knows the result (so it can calculate the rating).
  #
  # This method is private, because it is called automatically.
  # Therefore it is not part of the public API of Elo.
  def played(game)
    if game.ratings[self.id] != nil
      self.rating = game.ratings[self.id].new_rating
    end
    self.pro    = true if pro_rating?
    self.save!
  end


end
