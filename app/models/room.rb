class Room < ApplicationRecord
    belongs_to :category
    has_many :booking
    enum :state, [:Available, :Booked, :Blocked]
end
