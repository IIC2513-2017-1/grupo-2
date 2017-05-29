class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :user, :product, presence: true
  validates :amount, numericality: {greater_than: 0, only_integer: true}

  # Checks if there is another cart entry with the
  # same user and product and updates it
  def update_if_similar
    c = Cart.find_by(product: product, user: user)
    if c && valid?
      c[:amount] += amount
      c.save
      return true
    end
    return false
  end

end
