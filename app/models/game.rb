class Game < ActiveRecord::Base
  belongs_to :game_type, foreign_key: :gametype
  has_many :participations
end
