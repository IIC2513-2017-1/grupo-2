class Purchase < ApplicationRecord
  belongs_to :user
  has_many :purchase_products, dependent: :destroy

  def get_total
    sum = 0
    purchase_products.each do |p|
      sum += p.product.price * p.amount
    end
    sum
  end

  def nproducts
    count = 0
    purchase_products.each do |p|
      count += p.amount
    end
    count
  end

end
