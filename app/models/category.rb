class Category < ApplicationRecord
    has_one_attached :image
    has_many :room
    validates :name, uniqueness: true
    validates :content, presence: true, length: { minimum:200, maximum:400 }
    validates :amount, presence: true, numericality: { only_integer: true, greater_than: 1, less_than: 10000 }
    # validates :feature_ids_is_array

    # validates :image, attached: false, format: {
    #     with: %r{\.gif|jpg|png}i,
    #     message: 'must be a url for gif, jpg, or png image.'
    #   }
    def feature_ids_is_array
        errors.add(:feature_ids, "must be an array") unless feature_ids.kind_of?(Array)
    end

    # def self.with_features
    #     logger.info '------------- with_features ---------------'
    #     logger.info self.ids
    #     logger.info '------------- with_features ---------------'
    #     whereself.where()
    # end

    def with_features
        Feature.where(id: self.feature_ids)
    end
    
    def without_features
        Feature.where.not(id: self.feature_ids)
    end

end
