class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :contacts, :name, :phone
  end
end
