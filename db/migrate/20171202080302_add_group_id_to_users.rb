class AddGroupIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :group_id, :integer, index: true
    add_foreign_key :users, :groups, column: :group_id
  end
end
