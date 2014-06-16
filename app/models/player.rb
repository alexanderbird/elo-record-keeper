class Player < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  after_initialize :set_defaults
  def set_defaults
    self.rating ||= 1500
  end
  def to_s
    self.name
  end
end
