class Task < ApplicationRecord
  has_many :task_logs

  validates :name, :presence => true
  validates :value, :presence => true
  validates :duration_min, :presence => true
end
