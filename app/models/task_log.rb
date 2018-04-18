class TaskLog < ApplicationRecord
  belongs_to :task

  def started
    !self.start.nil?
  end

  def on_time
    self.start.getutc + self.task.duration_min * 60 > Time.now.getutc
  end

  def remaining_time
    remaining_time = self.task.duration_min
    if self.started
      remaining_time = (self.start.getutc + self.task.duration_min * 60) - DateTime.now.getutc
    end
    remaining_time > 0 ? remaining_time : 0
  end

end
