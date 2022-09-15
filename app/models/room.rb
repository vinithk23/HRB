class Room < ApplicationRecord
    belongs_to :categories
    has_many :bookings
end
