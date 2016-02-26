AdminUser.create!(
  email: 'admin@unlok.com',
  password: 'password',
  password_confirmation: 'password'
)

item_categories = [{name: 'aircraft', display_name: 'aircrafts'}, {name: 'helicopter', display_name: 'helicopters'}]

item_categories.each do |category|
  ItemCategory.find_or_create_by(category)
end

u = User.new(
  :email => "test@user.com",
  :password => '12341234',
  :password_confirmation => '12341234',
)
u.save!(:validate => false)
