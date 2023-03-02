class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :transaction_number, presence: true, uniqueness: true
  validates :credit_card_number, presence: true, length: {is: 16}
  validates :address, presence: true
  validates :phone_number, presence: true, length: {is: 10}
  validates :quantity, presence: true
  validates :total_cost, presence: true
end