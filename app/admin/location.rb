ActiveAdmin.register Location do

  permit_params :airport_location, :airport_name , :domestic, :region

  form do |f|
    f.inputs "Admin Details" do
      f.input :airport_location
      f.input :airport_name
      f.input :domestic, :label => 'Domestic', :as => :select,
              :collection => ["true","false"]
      f.input :region
    end
    f.actions
  end

  filter :airport_location
  filter :airport_name
  filter :region

end
