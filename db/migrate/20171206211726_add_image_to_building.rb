class AddImageToBuilding < ActiveRecord::Migration[5.1]
  def change
    add_column :buildings, :image, :string
  end
end
