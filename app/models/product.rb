class Product < ApplicationRecord
  validates :name, presence: true, allow_blank: false, uniqueness: true
  validates :price, presence: true, allow_blank: false,
                    numericality: {only_integer: true, greater_than: 0}
  validates :stock, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :offer, numericality: {only_integer: true, greater_than_or_equal_to: 0,
                    less_than_or_equal_to: 100, allow_nil: true}

  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy
  has_many :purchase_products, dependent: :destroy
  has_many :purchases, through: :purchase_products
  mount_uploader :image, ProductImageUploader

  scope :search_query, lambda { |query|
    terms = query.downcase.split(/\s+/)  # split on whitespace

    terms = terms.map { |e|
      ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }

    num_or_conds = 1
    where(
      terms.map { |term|
        "(LOWER(products.name) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

end
