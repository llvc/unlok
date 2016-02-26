class AddMessageToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :message, :string
  end
end
