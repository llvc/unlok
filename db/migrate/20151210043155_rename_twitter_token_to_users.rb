class RenameTwitterTokenToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :twitter_token, :g_token
  end
end
