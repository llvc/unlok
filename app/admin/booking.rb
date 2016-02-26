ActiveAdmin.register Booking do

  permit_params :bookable_type, :quantity , :date_of_journey, :from_location, :to_location, :aircraft_type, :trip_type,
                  :oneway_trip, :item_id, :message, :invoice_number


end