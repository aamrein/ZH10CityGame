class Game < ApplicationRecord
  has_many :groups, -> { order(id: :asc) }

  def end
    self.start.advance(hours: self.duration)
  end

  def running_hours
    now = DateTime.now
    duration_till_start = (now.getutc - self.start.getutc) / 3600
    duration_till_start > self.duration ? self.duration : duration_till_start
  end

  def is_running?
    DateTime.now.between? self.start, self.end
  end

  def to_s
    self.name
  end
end
