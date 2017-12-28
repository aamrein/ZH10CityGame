class AddConstructedBuildingIdToEventLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :event_logs, :constructed_building_id, :integer
  end
end
