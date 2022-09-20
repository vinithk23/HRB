class Category < ApplicationRecord
    has_one_attached :image
    has_many :room
    validates :name, uniqueness: true
    validates :user_cost, :guest_cost, :child_cost, presence: true, numericality: { only_integer: true, greater_than: 1, less_than: 10000 }
    # validates :feature_ids_is_array

    # validates :image, attached: false, format: {
    #     with: %r{\.gif|jpg|png}i,
    #     message: 'must be a url for gif, jpg, or png image.'
    #   }

    def feature_ids_is_array
        errors.add(:feature_ids, "must be an array") unless feature_ids.kind_of?(Array)
    end
end
