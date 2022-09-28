class HomeController < ApplicationController
  # before_action :set_room_details
  $room_category = ""
  $checkin_date = ""
  $checkout_date = ""
  $adult_count = 0
  $child_count = 0
  $reservation_days = 0

  def index
    $adult_count = 0
    $checkin_date = ""
    $checkout_date = ""
    $child_count = 0
    set_room_details()
    logger.info "index def..."
  end

  def available_rooms
    logger.info "Asking Available Room Details..."
    $checkin_date = params[:checkin_date]
    $checkout_date = params[:checkout_date]
    $adult_count = params[:adult_count]
    $child_count = params[:child_count]
    set_room_details()
    # pry($checkin_date)
    respond_to do |format|
      # format.turbo_stream { }
      format.html { render 'home/index', notice: "Search was successfully Received."}
    end
  end

  def reservation
    $room_category = params[:room_category]

    unless($checkin_date == "" && $checkout_date == "")
      $reservation_days = ((Date.parse($checkout_date) - Date.parse($checkin_date)).to_i) + 1
      logger.info "$reservation_days"
      logger.info $reservation_days
      logger.info "$reservation_days"
    end

    @requestCategory = Category.find($room_category)

  end

  private
  def set_room_details 
    logger.info "set room details.."
    if $adult_count != 0
      @available_category_ids = Room.where.not(status: 'Blocked').where.not(id: BookingDate.where(date: $checkin_date..$checkout_date).select(:room_id).distinct.pluck('room_id')).select(:category_id).distinct.pluck('category_id')

      # @available_category_ids = Room.where(status: 'Available').pluck('category_id').uniq
      @available_categories = Category.where(id: @available_category_ids)
      @booking_button_status = 1
    else 
      @available_categories = Category.all

      @booking_button_status = 0
    end
  end
end
