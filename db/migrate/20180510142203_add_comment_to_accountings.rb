class AddCommentToAccountings < ActiveRecord::Migration[5.2]
  def change
    add_column :accountings, :comment, :string
  end
end
