class AddTokensToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_token, :string
    add_column :users, :twitter_token, :string
    add_column :users, :device_token, :string
    add_column :users, :device_type, :string 
  end
end
