class HomeController < ApplicationController
  # before_action :set_room_details
  $checkin_date = ""
  $checkout_date = ""
  $adult_count = 0
  $child_count = 0

  def index
    $adult_count = 0
    $checkin_date = ""
    $checkout_date = ""
    $child_count = 0
    set_room_details()
    logger.info "index def..."
  end

  def available_rooms
    # pry("text!")
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

  end

  private
  def set_room_details 
    logger.info "set room details.."
    if $adult_count != 0
    @available_category_ids = Room.where(status: 'Available').pluck('category_id').uniq
    @available_categories = Category.where(id: @available_category_ids)
    @booking_button_status = 1
    else 
      @available_categories = Category.all
      @booking_button_status = 0
    end
  end
end
