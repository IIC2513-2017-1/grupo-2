json.array! @user.carts do |cart|
  json.href api_v1_user_cart_url(@user, cart)
  json.amount cart.amount
  json.user do
    json.href api_v1_user_url(@user)
    json.username @user.username
    json.email @user.email
    json.role @user.role.name
  end
  json.product do
    json.href api_v1_product_url(cart.product)
    json.name cart.product.name
    json.description cart.product.description
    json.price cart.product.price
    json.stock cart.product.stock
    json.offer cart.product.offer
  end
end
