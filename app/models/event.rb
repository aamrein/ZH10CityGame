class Event < ApplicationRecord
  validates :name, :presence => true
  validates :impact_percent, :presence => true
  validates :duration_min, :presence => true
end
