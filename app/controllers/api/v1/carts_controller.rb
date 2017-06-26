module Api::V1
  class CartsController < ApiController
    def index
      @user = User.find(params[:user_id])
    end

    def show
      @cart = Cart.find(params[:id])
    end

    def create
      @cart = Cart.new(cart_params)
      unless @cart.update_if_similar || @cart.save
        render json: { errors: @cart.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @cart = Cart.find(params[:id])
      @cart.destroy
      render json: {}, status: :no_content
    end

    private

    def cart_params
      params.require(:cart).permit(:product_id, :amount).merge(user_id: params[:user_id])
    end
  end
end
