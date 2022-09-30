class Booking < ApplicationRecord
    belongs_to :user
    belongs_to :room
    has_one :category, through: :room
end
