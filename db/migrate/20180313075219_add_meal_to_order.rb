class AddMealToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :meal, :string
  end
end
