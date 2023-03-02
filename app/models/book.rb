class Book < ApplicationRecord
    has_many :reviews, dependent: :destroy
    has_many :transactions, dependent: :destroy
    validates :name, presence: true
    validates :author, presence: true
    validates :publisher, presence: true
    validates :price, presence: true, numericality: {greater_than: 0}
    validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0,
                                                     only_integer: true}
end
