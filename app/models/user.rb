class User < ApplicationRecord
  has_many :purchases, dependent: :destroy
  has_many :carts
  has_many :wishes
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :password, length: {in: 6..20}, confirmation: true
end
