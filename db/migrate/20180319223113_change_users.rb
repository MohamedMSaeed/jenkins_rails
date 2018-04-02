class ChangeUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :image , :string , :default => 'user-512.png'
  end
end
