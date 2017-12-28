class CreateBuildings < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings do |t|
      t.belongs_to :category, foreign_key: true
      t.string :name
      t.integer :inhabitants
      t.integer :construction_duration_sec
      t.string :comment

      t.timestamps
    end
  end
end
