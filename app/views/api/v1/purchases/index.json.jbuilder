json.purchases do
  json.array! @user.purchases do |purchase|
    json.id purchase.id
    json.href api_v1_user_purchase_url(purchase.user, purchase)
    json.total_money purchase.get_total
    json.product_amount purchase.nproducts
    json.payment_confirmed purchase.payment_confirmed
    json.user do
      json.id @user.id
      json.href api_v1_user_url(purchase.user)
      json.username purchase.user.username
      json.email purchase.user.email
      json.role purchase.user.role.name
    end
    json.products do
      json.array! purchase.purchase_products do |pp|
        json.id pp.product.id
        json.href api_v1_product_url(pp.product)
        json.name pp.product.name
        json.description pp.product.description
        json.price pp.product.price
        json.stock pp.product.stock
        json.offer pp.product.offer
        json.amount pp.amount
      end
    end
  end
end
