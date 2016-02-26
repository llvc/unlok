class AddItemSpecificationToItems < ActiveRecord::Migration
  def change
    add_reference :items, :specification_category, index: true, foreign_key: true
  end
end
