json.cart do
  json.id @cart.id
  json.href api_v1_user_cart_url(@cart.user, @cart)
  json.amount @cart.amount
  json.user do
    json.id @cart.user.id
    json.href api_v1_user_url(@cart.user)
    json.username @cart.user.username
    json.email @cart.user.email
    json.role @cart.user.role.name
  end
  json.product do
    json.id @cart.product.id
    json.href api_v1_product_url(@cart.product)
    json.name @cart.product.name
    json.description @cart.product.description
    json.price @cart.product.price
    json.stock @cart.product.stock
    json.offer @cart.product.offer
  end
end
