ActiveAdmin.register City do
  index do
    selectable_column
    id_column
    column :domestic
    column :created_at
    actions
  end
end
ActiveAdmin.register Contact do
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :mobile
    column :message
    column :created_at
    column :mtype
    actions
  end
end
ActiveAdmin.register Item do
  index do
    selectable_column
    id_column
    column :name
    column :item_category
    column :specification_category
    column :price
    column :variant_price
    column :discount
    column :'Total picture' do |img|
      label img.pictures.count, height: '50',width: '60'
    end
    column :created_at
    actions
  end
end

ActiveAdmin.register Plane do
  index do
    selectable_column
    id_column
    column :name
    column :type
    column :flight_type
    column :from_place
    column :to_place
    column :created_at
    actions
  end
end

ActiveAdmin.register SpecificationCategory do
  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end
end

ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :email
    column :username
    column :mobile_number
    column :current_sign_in_at
    column :last_sign_in_at
    column :created_at
    column :device_type
    actions
  end
end
