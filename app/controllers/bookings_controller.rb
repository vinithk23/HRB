class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: %i[ show reservation_confirmation ]

      # GET /booking or /booking.json
      def index
        @bookings = Booking.where(user_id: current_user.id)
      end
     
      # GET /booking/all or /booking/all.json
      def all
        if (current_user.role.name != 'Admin')
          redirect_back_or_to '/', allow_other_host: false, alert: "Your request can't be processed.."
          return
        end
        @bookings = Booking.all
        render 'index'
      end

    # GET /booking/1 or /booking/1.json
    def show

    end

    def new
        @selected_category = Category.find($room_category)
        
        @booking = Booking.new(booking_params)
        
        # availableRoomIds = Room.where.not(status: 'Blocked').where.not(id: BookingDate.where(date: $checkin_date..$checkout_date).select(:room_id).distinct.pluck('room_id')).select(:category_id).distinct.pluck('category_id')
        availableRoomIds = Room.where.not(status: 'Blocked').where.not(id: BookingDate.where(date: $checkin_date..$checkout_date).select(:room_id).distinct.pluck('room_id')).where(category_id: $room_category).pluck('id')

        @booking.user_id = current_user.id
        @booking.room_id = availableRoomIds.first    
        @booking.save
     
        if @booking.persisted?
              ($checkin_date..$checkout_date).each do |date|
                  BookingDate.create!(room_id: @booking.room_id, booking_id: @booking.id, date: date)
              end
            redirect_to reservation_confirmation_path(@booking)
          else
            redirect_back_or_to '/', allow_other_host: false, alert: "Your Reservation has not been processed, Kindly try again.."
        end
    end

    def reservation_confirmation

      # @booking = Booking.find(params[:booking_id])

      if @booking.user_id == current_user.id
      render 'home/reservation_confirmation', notice: "Your Reservation have been Confirmed."
      else 
        redirect_back_or_to '/', allow_other_host: false, alert: "Your Request can't be process.."
      end 
    end

    def cancellation

      logger.info 'Cancellation action'

    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:booking_id])
    end

    def booking_params
        params.permit( :user_id, :check_in, :check_out, :adult_count, :child_count, :per_day_amount, :amount, :notes)
    end
end
