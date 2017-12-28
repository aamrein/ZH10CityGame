class CreateEventLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :event_logs do |t|
      t.belongs_to :event, foreign_key: true
      t.datetime :start
      t.string :comment

      t.timestamps
    end
  end
end
