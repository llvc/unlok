class ItemSpecification < ActiveRecord::Base
  belongs_to :item
  belongs_to :specification_category
end
