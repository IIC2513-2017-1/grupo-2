class HomeController < ApplicationController

  def index
    pre_products = Product.all
    @popular_products = []
    pre_products.each do |product|
      if @popular_products.size < 3
        @popular_products << product
      elsif @popular_products[2].purchases.size < product.purchases.size
        @popular_products[2] = product
        if @popular_products[2].purchases.size > @popular_products[1].purchases.size
          aux_product = @popular_products[1]
          @popular_products[1] = @popular_products[2]
          @popular_products[2] = aux_product
          if @popular_products[1].purchases.size > @popular_products[0].purchases.size
            aux_product = @popular_products[0]
            @popular_products[0] = @popular_products[1]
            @popular_products[1] = aux_product
          end
        end
      end
    end
    @newest_products = Product.all.order("products.created_at DESC").limit(3)
  end

end
