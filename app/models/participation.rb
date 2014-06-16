class Participation < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  validates_presence_of :player_id, :score, :team_number
  validates_associated :player
end
