class SpecificationCategory < ActiveRecord::Base
  validates :name, presence: true
  has_many :items, class_name: 'Item', foreign_key: 'specification_category_id'
end
