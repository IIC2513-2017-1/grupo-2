class Product < ApplicationRecord
  validates :name, presence: true, allow_blank: false, uniqueness: true
  validates :price, presence: true, allow_blank: false,
                    numericality: {only_integer: true, greater_than: 0}
  validates :stock, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :offer, numericality: {only_integer: true, greater_than_or_equal_to: 0,
                    less_than_or_equal_to: 100, allow_nil: true}

  has_and_belongs_to_many :categories
  has_many :comments
end
