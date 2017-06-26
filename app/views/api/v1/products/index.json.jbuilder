json.products do
  json.array! @products do |product|
    json.id product.id
    json.href api_v1_product_url(product)
    json.name product.name
    json.description product.description
    json.price product.price
    json.stock product.stock
    json.offer product.offer
    json.comments do
      json.array! product.comments do |comment|
        json.id comment.id
        json.content comment.content
        json.username comment.user.username
      end
    end
    json.purchases do
      json.array! product.purchases do |purchase|
        json.id purchase.id
        json.href api_v1_user_purchase_url(purchase.user, purchase)
        json.total_money purchase.get_total
        json.product_amount purchase.nproducts
        json.payment_confirmed purchase.payment_confirmed
      end
    end
  end
end
