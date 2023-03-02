class User < ApplicationRecord
  has_secure_password
  has_many :transactions, dependent: :destroy
  validates :email, presence: true, uniqueness: true,
            format: { with: /\A(\S+)@(.+)\.(\S+)\z/, message: "must be a valid email address" }
  has_many :reviews, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :phone_number, length: {is: 10}, allow_blank: true
  validates :credit_card_number, length: {is: 16}, allow_blank: true
end
