class Category < ApplicationRecord
  validates :name, null: false, allow_blank: false

  has_and_belongs_to_many :products

  def money_amount
    sum = 0
    products.each do |product|
      product.purchase_products.each do |pp|
        sum += pp.amount * product.current_price
      end
    end
    sum
  end

  def product_amount
    sum = 0
    products.each do |product|
      product.purchase_products.each do |pp|
        sum += pp.amount
      end
    end
    sum
  end
end
