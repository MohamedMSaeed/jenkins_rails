class CreateInvitedToOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :invited_to_orders do |t|
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
