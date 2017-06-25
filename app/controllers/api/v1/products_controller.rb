module Api::V1
  class ProductsController < ApiController
    def index
      @products = Product.all
    end

    def show
      @product = Product.find(params[:id])
    end
  end
end
