class AddAmountPerInhabitantsToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :amount_per_inhabitants_per_hour, :integer
  end
end
