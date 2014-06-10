class Game < ActiveRecord::Base

  # The result is the result of the match. It's a nubmer
  # from 0 to 1 from the perspective of player +:one+.
  has_many :results

  def result
  end

  def score
  end

  # The first Elo::Player. The result is in perspecive of
  # this player.
  has_many :players, through: :results
  def one
    if self.players.present?
      return self.players[0]
    end
  end
  def two 
    if self.players.to_s.count >= 1
      return self.players[1]
    end
  end

  # Every time a result is set, it tells the Elo::Player
  # objects to update their scores.
  def process_result(player, result)
    result_object = nil
    self.results.to_a.each do |result|
      if result.player == player
        result_object = result
      end
    end
    result_object.value = result
    result_object.save!
    calculate
  end

  def calculate
    if scoring_complete?
      self.save && self.reload
      self.results.each do |r|
        r.player.send :played, self
      end
    end
  end

  # It was a draw.
  # This is a shortcut method for setting the score to 0.5
  def draw
    self.results.to_a.each do |result|
      result.value = 0.5
      result.save!
    end
  end

  # Set the winner. Provide it with a Elo::Player. 
  def winner=(player)
    self.save && self.reload
    # The winner scores 1
    process_result(player, 1)
    # The other players score 0
    self.players.to_a.each do |one_player|
      unless one_player == player
        process_result(one_player, 0)
      end
    end
  end

  # Set the loser. Provide it with a Elo::Player. 
  def loser=(player)
    self.save && self.reload
    process_result(player, 0.0)
    self.players.to_a.each do |one_player|
      unless one_player == player
        process_result(one_player, 1.0)
      end
    end
  end

  # Access the Elo::Rating objects for both players.
  def ratings
    to_return = {}
    players_array = self.players.to_a
    if players_array.size > 2
      to_return = {players_array[0].id => create_rating(players_array[0], players_array[1]), 
                    players_array[1].id => create_rating(players_array[1], players_array[0])}
    end
    to_return
  end

  def record(player, score)
    save!
    new_result = Result.where(player: player, game: self).first
    if new_result
      new_result.value = score
      new_result.save!
    else
      new_result = Result.create(player: player, value: score)
      self.results << new_result
    end
    calculate
  end

  def participants(players = [])
    players.each do |player|
      self.results << Result.create(player: player)
    end
  end

  def scoring_complete?
    self.results.to_a.each do |r|
      if r.value == nil
        return false
      end
    end
    return true
  end

  private
  def create_rating(one, two)
    result = nil
    self.results.to_a.each do |r|
      if r.player == one
        result = r
      end
    end
    Elo::Rating.new(:result        => result,
               :old_rating    => one.rating,
               :other_rating  => two.rating,
               :k_factor      => one.k_factor)
  end

  # Create an Elo::Rating object for player one
  def rating_one
    raise "depracated"
    Elo::Rating.new(:result        => result,
               :old_rating    => one.rating,
               :other_rating  => two.rating,
               :k_factor      => one.k_factor)
  end

  # Create an Elo::Rating object for player two
  def rating_two
    raise "depracated"
    Elo::Rating.new(:result        => (1.0 - result),
               :old_rating    => two.rating,
               :other_rating  => one.rating,
               :k_factor      => two.k_factor)
  end


end
