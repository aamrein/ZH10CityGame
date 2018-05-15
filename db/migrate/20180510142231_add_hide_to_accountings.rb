class AddHideToAccountings < ActiveRecord::Migration[5.2]
  def change
    add_column :accountings, :hide, :boolean, default: false
  end
end
