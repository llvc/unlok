class AddTripdateToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :tripdate, :string
    add_column :bookings, :triptime, :string
  end
end
