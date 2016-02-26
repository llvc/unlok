class AddDisplayNameToItemCategories < ActiveRecord::Migration
  def change
    add_column :item_categories, :display_name, :string
  end
end
