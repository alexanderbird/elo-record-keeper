class Result < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  def to_s
    self.value.to_s
  end
  def to_f
    self.value.to_f
  end
end
