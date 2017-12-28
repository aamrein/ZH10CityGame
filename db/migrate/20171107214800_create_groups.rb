class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.belongs_to :game, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone
      t.decimal :start_balance
      t.string :comment

      t.timestamps
    end
  end
end
