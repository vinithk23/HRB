class Booking < ApplicationRecord
    belongs_to :user
    belongs_to :room
    has_one :category, through: :room
    scope :is_admin, -> { current_user.role.name == where(out_of_print: false) }
end
