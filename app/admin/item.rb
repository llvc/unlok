ActiveAdmin.register Item do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
#permit_params :list, :of, :attributes, :on, :model
  permit_params :item_category_id, :specification_category_id , :name, :description, :price, :variant_price, :discount,
                :pictures_attributes => [:id, :image, :_destroy], :item_specifications_attributes => [:id, :skey, :svalue, :specification_category_id, :_destroy]
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


  form do |f|
    f.inputs "Details", allow_destroy: true  do
      f.input :item_category
      f.input :name
      f.input :description
      f.input :price
      f.input :variant_price
      f.input :discount

      f.has_many :item_specifications, label: 'Item Specifications', allow_destroy: true  do |i|
        i.input :skey, required: false, label: 'Key'
        i.input :svalue , required: false, label: 'Value'
        i.input :specification_category, as: :select, collection: SpecificationCategory.pluck(:name, :id)
      end

      f.has_many :pictures, allow_destroy: true do |img|
        img.input :image, :as => :file, required: false, :hint => image_tag(img.object.image.url(:thumb))
      end
    end
    f.actions
  end
end
