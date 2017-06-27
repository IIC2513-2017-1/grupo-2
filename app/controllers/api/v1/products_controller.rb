module Api::V1
  class ProductsController < ApiController
    before_action :authenticate, only: [:create, :update, :destroy]

    def index
      @products = Product.all
    end

    def show
      @product = Product.find(params[:id])
    end

    def create
      unless @current_user.role.name == "admin"
        render( json: {} ) and return
      end
      @product = Product.new(product_params)
      unless @product.save
        render json: { errors: @cart.errors }, status: :unprocessable_entity
      end
    end

    def update
      unless @current_user.role.name == "admin"
        render( json: {} ) and return
      end
      @product = Product.find(params[:id])
      unless @product.update(product_params)
        render json: { errors: @cart.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      unless @current_user.role.name == "admin"
        render( json: {} ) and return
      end
      @product = Product.find(params[:id])
      @product.destroy
      render json: {}, status: :no_content
    end

    private

    def product_params
      params.require(:product).permit(:name, :description, :image, :price, :stock, :offer, categories: []).merge(categories: find_categories)
    end

    def find_categories
      if params[:product][:categories]
        Category.find(params[:product][:categories])
      else
        []
      end
    end
  end
end
