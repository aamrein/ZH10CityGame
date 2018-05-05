class CreateAccountings < ActiveRecord::Migration[5.1]
  def change
    create_table :accountings do |t|
      t.belongs_to :group, foreing_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
