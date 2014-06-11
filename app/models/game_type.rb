class GameType < ActiveRecord::Base
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
end
