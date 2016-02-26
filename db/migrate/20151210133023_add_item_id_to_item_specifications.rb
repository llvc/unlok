class AddItemIdToItemSpecifications < ActiveRecord::Migration
  def change
    add_column :item_specifications, :item_id, :integer
  end
end
