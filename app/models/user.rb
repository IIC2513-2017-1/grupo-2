class User < ApplicationRecord
  has_secure_password


  before_validation :set_default_role

  has_many :purchases, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :role

  validates :username, presence: true
  validates :username, :email, uniqueness: true
  validates :password, length: {in: 6..20}, confirmation: true
  validates :email, presence: true, format: {with: /[\S]+@[\S]+\.[\S]+/}


  private
  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
