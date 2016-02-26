class CreateProfile < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name
      t.string :gender
      t.string :mobile_number
      t.string :location
      t.string :shipping_address
      t.string :billing_address
    end
  end
end
