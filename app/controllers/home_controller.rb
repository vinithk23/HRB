class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[ reservation ]

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
  end

  def available_rooms
    logger.info "Asking Available Room Details..."
    $checkin_date = params[:checkin_date]
    $checkout_date = params[:checkout_date]
    $adult_count = params[:adult_count]
    $child_count = params[:child_count]
    set_room_details()
    respond_to do |format|
      format.html { render 'home/index', notice: "Search was successfully Received."}
    end
  end

  def reservation
    $room_category = params[:room_category]

    unless($checkin_date == "" && $checkout_date == "")
      $reservation_days = ((Date.parse($checkout_date) - Date.parse($checkin_date)).to_i) + 1
    end
    @requestCategory = Category.find($room_category)

  end

  private
  def set_room_details 
    if $adult_count != 0
      @available_category_ids = Room.where.not(status: 'Blocked').where.not(id: BookingDate.where(date: $checkin_date..$checkout_date).select(:room_id).distinct.pluck('room_id')).select(:category_id).distinct.pluck('category_id')
      @available_categories = Category.where(id: @available_category_ids).order(:amount)
      @booking_button_status = 1
    else 
      @available_categories = Category.order(:amount)
      @booking_button_status = 0
    end
  end
end
