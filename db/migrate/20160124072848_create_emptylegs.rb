class CreateEmptylegs < ActiveRecord::Migration
  def change
    create_table :emptylegs do |t|
      t.string :aircraft_type
      t.string :departon
      t.string :from
      t.string :to
      t.integer :seats
      t.decimal :price
      t.decimal :min_price

      t.timestamps null: false
    end
  end
end
