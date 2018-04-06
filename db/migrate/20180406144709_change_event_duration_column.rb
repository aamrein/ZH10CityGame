class ChangeEventDurationColumn < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :events, :duration_sec, :duration_min
    Event.all.each {|event|
      unless event[:duration_min].nil?
        event.update_attribute :duration_min, (event[:duration_min] / 60)
      end
    }
  end

  def self.down
    rename_column :events, :duration_min, :duration_sec
    Event.all.each {|event|
      unless event[:duration_sec].nil?
        event.update_attribute :duration_sec, (event[:duration_sec] * 60)
      end
    }
  end
end
