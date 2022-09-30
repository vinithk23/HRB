class ReservationMailer < ApplicationMailer
    
    def send_reservation_confirmation_email(user)
        mail( to: user, subject: "test mail" )
    end

end
