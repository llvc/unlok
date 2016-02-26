class UserMailer < ApplicationMailer
  def booking_email(booking)  
    @booking = booking 
    mail(to: "contact@unlok.in", from: "Customer", subject: 'Hello')
  end

  def booking_response_email(booking)
    @booking = booking
    mail(to: booking.user.email, subject: 'Thank you for your booking')
  end

  def contact_email(contact)  
    @contact = contact 
    mail(to: "contact@unlok.in", from: "Customer", subject: 'Hello')
  end
end
