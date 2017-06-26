json.user do
  json.id @user.id
  json.href api_v1_user_url(@user)
  json.username @user.username
  json.email @user.email
  json.role @user.role.name
  json.carts do
    json.array! @user.carts do |cart|
      json.href api_v1_user_cart_url(@user, cart)
      json.amount cart.amount
    end
  end
  json.purchases do
    json.array! @user.purchases do |purchase|
      json.href api_v1_user_purchase_url(@user, purchase)
      json.total_money purchase.get_total
      json.product_amount purchase.nproducts
      json.payment_confirmed purchase.payment_confirmed
    end
  end
end
