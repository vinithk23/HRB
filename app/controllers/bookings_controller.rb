class BookingsController < ApplicationController
    def new
        @selected_category = Category.find($room_category)
        
        logger.info '-----------------------'
        logger.info @selected_category.name
        logger.info '-----------------------'

        @booking = Booking.new(booking_params)
        @booking.user_id = current_user.id
        @booking.room_id = 6

        logger.info '-----------------------'
        logger.info @booking.check_in
        logger.info '-----------------------'


        if @booking.save
            render 'home/reservation_confirmation', notice: "Your Reservation have been Confirmed."
          else
            # redirect_to :back, alert: "Your Reservation have not been Confirmed."
            redirect_back_or_to '/', allow_other_host: false, alert: "Your Reservation has not been processed, Kindly try again.."
        end
    end

    private
    def booking_params
        params.permit( :user_id, :check_in, :check_out, :adult_count, :child_count, :notes)
      end
end
