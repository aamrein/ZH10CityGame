class AddCostPerHourToBuildings < ActiveRecord::Migration[5.1]
  def change
    add_column :buildings, :cost_per_hour, :integer
    add_column :buildings, :income_per_hour, :integer
  end
end
