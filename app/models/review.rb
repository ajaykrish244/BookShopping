class Review < ApplicationRecord
    validates :book_id, :user_id, :presence => true
    validates_length_of :review, minimum: 3, maximum: 250
    validates_numericality_of :rating, less_than_or_equal_to: 5, greater_than_or_equal_to: 1
    belongs_to :book
    belongs_to :user
end
