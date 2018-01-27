class CreateTaskLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :task_logs do |t|
      t.belongs_to :task, foreign_key: true
      t.belongs_to :group, foreing_key: true
      t.datetime :start
      t.string :comment
      t.boolean :done

      t.timestamps
    end
  end
end
