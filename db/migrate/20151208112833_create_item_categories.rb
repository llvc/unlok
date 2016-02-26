class CreateItemCategories < ActiveRecord::Migration
  def change
    create_table :item_categories do |t|
      t.string  :name, :null => false, :default => ""
      t.integer :parent_category_id

      t.timestamps null: false
    end
  end
end
