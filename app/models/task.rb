class Task < ApplicationRecord
  has_many :task_logs

  def duration_min
    self.duration_sec / 60
  end

end
