class AddItemCategoryToItems < ActiveRecord::Migration
  def change
    add_reference :items, :item_categories, index: true, foreign_key: true
  end
end
