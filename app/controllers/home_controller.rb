class HomeController < ApplicationController

  def index
    pre_products = Product.all
    @products = []
    pre_products.each do |product|
      if @products.size < 3
        @products << product
      elsif @products[2].purchases.size < product.purchases.size
        @products[2] = product
        if @products[2].purchases.size > @products[1].purchases.size
          aux_product = @products[1]
          @products[1] = @products[2]
          @products[2] = aux_product
          if @products[1].purchases.size > @products[0].purchases.size
            aux_product = @products[0]
            @products[0] = @products[1]
            @products[1] = aux_product
          end
        end
      end
    end
  end

end
