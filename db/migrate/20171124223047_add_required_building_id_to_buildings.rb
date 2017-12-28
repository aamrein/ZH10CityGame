class AddRequiredBuildingIdToBuildings < ActiveRecord::Migration[5.1]
  def change
    add_column :buildings, :required_building_id, :integer, index: true
    add_foreign_key :buildings, :buildings, column: :required_building_id
  end
end
