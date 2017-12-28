class CreateConstructedBuildings < ActiveRecord::Migration[5.1]
  def change
    create_table :constructed_buildings do |t|
      t.belongs_to :building, foreign_key: true
      t.belongs_to :group, foreign_key: true
      t.datetime :construction_time

      t.timestamps
    end
  end
end
