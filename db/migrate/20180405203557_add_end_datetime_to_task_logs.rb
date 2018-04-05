class AddEndDatetimeToTaskLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :task_logs, :end, :datetime
  end
end
