class RenameMobileColumnToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :mobile, :mobile_number
  end
end
