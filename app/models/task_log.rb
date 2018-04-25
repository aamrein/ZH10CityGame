class TaskLog < ApplicationRecord
  belongs_to :task

  def started
    !self.start.nil?
  end

  def on_time
    if started
      self.start.getutc + self.task.duration_min * 60 > Time.now.getutc
    else
      true
    end
  end

  def remaining_time
    remaining_time = self.task.duration_min
    if self.started
      remaining_time = (self.start.getutc + self.task.duration_min * 60) - DateTime.now.getutc
    end
    remaining_time > 0 ? remaining_time : 0
  end

  def current_amount
    amount = 0
    task = self.task
    if task.value > 0
      if self.done
        amount = task.value
      end
    else
      if !self.done && (!self.on_time || self.game.is_over?)
        amount = task.value
      end
    end
    amount
  end

end
