require 'sidekiq-scheduler'

class CompletedBookingStatusUpdateJob
  include Sidekiq::Job
  sidekiq_options queue: 'default'

  def perform(*args)
    ActiveRecord::Base.transaction do
      Booking.where(check_out: Date.yesterday, status: 'Active').update(status: 'Completed')
      BookingDate.where(date: Date.yesterday).delete_all
    end
  end
end
