class RemoveFieldUserNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :username, :string
  end
end
