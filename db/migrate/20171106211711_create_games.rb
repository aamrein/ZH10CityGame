class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :name
      t.datetime :start
      t.integer :duration

      t.timestamps
    end
  end
end
