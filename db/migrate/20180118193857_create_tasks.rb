class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.string :location
      t.integer :duration_sec
      t.integer :value
      t.string :comment
      t.boolean :settlement_immediately
      t.boolean :optional

      t.timestamps
    end
  end
end
