class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :airport_location
      t.string :airport_name
      t.string :domestic
      t.string :region

      t.timestamps null: false
    end
  end
end
