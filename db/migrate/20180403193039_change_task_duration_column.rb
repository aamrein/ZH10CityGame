class ChangeTaskDurationColumn < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :tasks, :duration_sec, :duration_min
    Task.all.each {|task|
      unless task[:duration_min].nil?
        task.update_attribute :duration_min, (task[:duration_min] / 60)
      end
    }
  end

  def self.down
    rename_column :tasks, :duration_min, :duration_sec
    Task.all.each {|task|
      unless task[:duration_sec].nil?
        task.update_attribute :duration_sec, (task[:duration_sec] * 60)
      end
    }
  end
end
