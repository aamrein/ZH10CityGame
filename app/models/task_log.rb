class TaskLog < ApplicationRecord
  belongs_to :task

  def started
    !self.start.nil?
  end

end
