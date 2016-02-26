class AddInvoiceNumberToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :invoice_number, :string
  end
end
