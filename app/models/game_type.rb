class GameType < ActiveRecord::Base
  validates_presence_of :name, :number_of_teams, :players_per_team
  validates :number_of_teams, numericality: {greater_than: 1}
  validates :players_per_team, numericality: {greater_than: 0}
  def to_s
    self.name
  end
  def score_string_help_text
    help_array = []
    self.number_of_teams.times do 
      help_array << "X"
    end
    return help_array.join("-")
  end
  def team_descriptor
    self.players_per_team > 1 ? "Team" : "Player"
  end

  def total_number_of_players
    self.players_per_team * self.number_of_teams
  end
end
