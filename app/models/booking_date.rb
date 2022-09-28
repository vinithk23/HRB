class BookingDate < ApplicationRecord
    belongs_to :booking
    belongs_to :room
end
