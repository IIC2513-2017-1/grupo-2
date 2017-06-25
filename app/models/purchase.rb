class Purchase < ApplicationRecord
  belongs_to :user
  has_many :purchase_products, dependent: :destroy

  def get_total
    sum = 0
    purchase_products.each do |purchase|
      sum += purchase.product.current_price * purchase.amount
    end
    sum
  end

  def nproducts
    count = 0
    purchase_products.each do |purchase|
      count += purchase.amount
    end
    count
  end

  scope :pending, lambda { where(:payment_confirmed => false) }

end
