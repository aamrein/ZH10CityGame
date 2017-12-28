class Event < ApplicationRecord
  def duration_min
    self.duration_sec / 60
  end
end
