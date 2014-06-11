class Game < ActiveRecord::Base
  belongs_to :game_type, foreign_key: :gametype
  has_many :participations
  def team_descriptor
    self.game_type.players_per_team > 1 ? "Team" : "Player"
  end
end
