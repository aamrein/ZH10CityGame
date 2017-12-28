class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :impact_percent
      t.integer :duration_sec
      t.string :comment

      t.timestamps
    end
  end
end
