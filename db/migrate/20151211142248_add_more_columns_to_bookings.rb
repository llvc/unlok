class AddMoreColumnsToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :from_location, :string
    add_column :bookings, :to_location, :string
    add_column :bookings, :user_id, :integer, index: true, foreign_key: true
    add_column :bookings, :aircraft_type, :string
    add_column :bookings, :trip_type, :boolean, default: false
    add_column :bookings, :oneway_trip, :boolean, default: false
    add_column :bookings, :item_id, :integer, index: true, foreign_key: true
  end
end
