class AddMtypeToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :mtype, :string
  end
end
