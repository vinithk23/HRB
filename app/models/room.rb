class Room < ApplicationRecord
    belongs_to :category
    has_many :booking
    enum :state, [:Available, :Blocked]
    validates :room_no, presence:true, uniqueness: true, numericality: { only_integer: true, greater_than: 1, less_than: 10000 }
    validates :status, acceptance: { accept: Room.states.keys.to_a }
end
