class Booking < ActiveRecord::Base
  before_create :increase_invoice_number

  validates :quantity, :bookable_type, :aircraft_type, presence: true
  belongs_to :user

  def increase_invoice_number
    new_id = Booking.order(:id).last.try(:id) || 0
    new_id = new_id + 1
    self.invoice_number = 'ULK_' + new_id.to_s.rjust(9, '0')
  end
end
