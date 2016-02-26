class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :bookable, polymorphic: true, index: true
      t.integer    :quantity, :null => false, :default => 0
      # Set the journey date in case of plane booking
      t.date       :date_of_journey

      t.timestamps null: false
    end
  end
end
