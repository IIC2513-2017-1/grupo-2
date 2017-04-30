class User < ApplicationRecord
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :password, length: {in: 6..20}, confirmation: true
end
