class ReservationMailer < ApplicationMailer
    
    def send_reservation_confirmation_email(booking, current_user)
        @booking = booking
        @current_user = current_user
        mail( to: current_user.email, subject: "HRB Reservation Confirmation Mail" )
    end

end
