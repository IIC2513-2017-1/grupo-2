json.array! @products do |product|
  json.href api_v1_product_url(product)
  json.name product.name
  json.desscription product.description
  json.price product.price
  json.stock product.stock
  json.offer product.offer
end
