class CreateItemSpecifications < ActiveRecord::Migration
  def change
    create_table :item_specifications do |t|
      t.integer :specification_category_id
      t.string :skey
      t.string :svalue

      t.timestamps null: false
    end
  end
end
