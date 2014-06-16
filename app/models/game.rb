class Game < ActiveRecord::Base
  belongs_to :game_type
  has_many :participations
  validates_presence_of :date, :game_type

  validate :fullness

  def fullness
    unless self.full? || (self.game_type && self.game_type.name == "Generic Factory-Made Game Type")
      self.errors[:base] << "Missing #{self.missing_players} players"
    end
  end
  
  def full?
    unless self.game_type
      return false
    end
    expected = self.game_type.total_number_of_players
    actual = self.participations.count
    participants_valid = true
    self.participations.to_a.each do |participant|
      participants_valid = participants_valid && participant.valid?
    end
    return (actual == expected && participants_valid)
  end
  
  def participants
    self.participations.to_a.collect {|p|; p.player;}
  end

  def missing_players
    valid_participants = 0
    self.participations.to_a.each do |participation|
      if participation.valid?
        valid_participants += 1
      end
    end
    if game_type
      return game_type.total_number_of_players - valid_participants
    else 
      return 0
    end
  end
end
