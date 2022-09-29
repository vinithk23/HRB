class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
        @totalRoomsCount = Room.count
        @todayBookedRoomsCount = BookingDate.where(date: Date.today).count
        @totalBlockedRoomsCount = Room.where(status: 'Blocked').count
        @totalAvailableRoomsCount = @totalRoomsCount - (@todayBookedRoomsCount + @totalBlockedRoomsCount)
        case current_user.role.name.gsub(/\s+/, "").underscore.to_sym
        when :admin
            @recentBookings = Booking.includes(:user, :category).order(created_at: :desc).last(15)
        when :customer
            @recentBookings = Booking.includes(:user, :category).where(user_id: current_user.id).order(created_at: :desc).last(15)
        end
    end
end
