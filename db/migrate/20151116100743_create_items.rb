class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      
      t.integer :item_category_id
      t.string  :name, :null => false, :default => "" 
      t.string  :description
      t.float   :price
      t.float   :variant_price, :null => false, :default => 0
      t.float   :discount, :null => false, :default => 0 

      t.timestamps null: false
    end
  end
end
