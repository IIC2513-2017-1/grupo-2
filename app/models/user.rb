class User < ApplicationRecord
  has_secure_password

  before_create :confirmation_token
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



  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private
  def set_default_role
    self.role ||= Role.find_by_name('user')
  end

  def confirmation_token
    if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end
