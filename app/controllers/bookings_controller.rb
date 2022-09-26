class BookingsController < ApplicationController
  before_action :authenticate_user!

    def new
        @selected_category = Category.find($room_category)
        
        @booking = Booking.new(booking_params)
        
        # availableRoomIds = Room.where.not(status: 'Blocked').where.not(id: BookingDate.where(date: $checkin_date..$checkout_date).select(:room_id).distinct.pluck('room_id')).select(:category_id).distinct.pluck('category_id')
        availableRoomIds = Room.where.not(status: 'Blocked').where.not(id: BookingDate.where(date: $checkin_date..$checkout_date).select(:room_id).distinct.pluck('room_id')).where(category_id: $room_category).pluck('id')

        @booking.user_id = current_user.id
        @booking.room_id = availableRoomIds.first    
        @booking.save
     
        if @booking.persisted?
          logger.info '--------- BookingDate Loop --------------'
        # logger.info @booking.check_in
        ($checkin_date..$checkout_date).each do |date|
          logger.info date
          BookingDate.create!(room_id: @booking.room_id, booking_id: @booking.id, date: date)
        end
        logger.info '-----------------------'
          redirect_to reservation_confirmation_path(@booking)
          else
            redirect_back_or_to '/', allow_other_host: false, alert: "Your Reservation has not been processed, Kindly try again.."
        end
    end

      
    def reservation_confirmation

      @booking = Booking.find(params[:booking_id])

      if @booking.user_id == current_user.id
      render 'home/reservation_confirmation', notice: "Your Reservation have been Confirmed."
      else 
        redirect_back_or_to '/', allow_other_host: false, alert: "Your Request can't be process.."
      end 
    end


    private

    def booking_params
        params.permit( :user_id, :check_in, :check_out, :adult_count, :child_count, :per_day_amount, :amount, :notes)
    end
end
