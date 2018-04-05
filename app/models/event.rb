class Event < ApplicationRecord
  validates :name, :presence => true
  validates :impact_percent, :presence => true
  validates :duration_sec, :presence => true

  def duration_min
    self.duration_sec / 60
  end
end
