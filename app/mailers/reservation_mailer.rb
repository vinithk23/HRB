class ReservationMailer < ApplicationMailer
    
    def send_reservation_email(booking, current_user)
        @booking = booking
        @current_user = current_user
        mail( to: current_user.email, subject: "HRB Reservation Information Mail" )
    end

end
