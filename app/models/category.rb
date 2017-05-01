class Category < ApplicationRecord
  validates :name, null: false, allow_blank: false

  has_and_belongs_to_many :products
end
