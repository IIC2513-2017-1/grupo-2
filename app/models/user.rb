class User < ApplicationRecord
  has_many :purchases, dependent: :destroy
  has_many :carts
  has_many :wishes
  belongs_to :role
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :password, length: {in: 6..20}, confirmation: true

  before_validation :set_default_role

  private
  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end
end
