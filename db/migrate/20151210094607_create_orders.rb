class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :shopping_cart_id
      t.float :amount

      t.timestamps null: false
    end
  end
end
