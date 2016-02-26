class Item < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  acts_as_paranoid

  belongs_to :item_category
  belongs_to :specification_category, foreign_key: 'specification_category_id'
  has_many :item_specifications, :dependent => :destroy, foreign_key: 'item_id'
  has_many :pictures, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :item_specifications, :allow_destroy => true, reject_if: :all_blank
end
