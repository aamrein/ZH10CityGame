class AddBuildingBanToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :building_ban, :boolean, :default => false
  end
end
