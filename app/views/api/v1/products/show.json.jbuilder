json.product do
  json.href api_v1_product_url(@product)
  json.name @product.name
  json.desscription @product.description
  json.price @product.price
  json.stock @product.stock
  json.offer @product.offer
  json.comments do
    json.array! @product.comments do |comment|
      json.content comment.content
      json.username comment.user.username
    end
  end
end
