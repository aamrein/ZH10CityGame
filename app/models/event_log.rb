class EventLog < ApplicationRecord
  belongs_to :event
  belongs_to :constructed_building

  def end
    self.start.advance(minutes: self.event.duration_min)
  end

  def remaining_time
    remaining_time = (self.start.getutc + self.event.duration_min * 60) - DateTime.now.getutc
    remaining_time > 0 ? remaining_time : 0
  end

  def remaining_impact
    remaining_impact = self.event.impact_percent * (self.remaining_time / (self.event.duration_min * 60))
    remaining_impact > 0 ? remaining_impact : 0
  end
end
