class ShoppingCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item
  belongs_to :item, :class_name => "Item", :foreign_key => "item_id"
  belongs_to :item_including_deleted, :class_name => "Item", :foreign_key => "item_id", :with_deleted => true

end
