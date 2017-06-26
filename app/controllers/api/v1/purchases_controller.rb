module Api::V1
  class PurchasesController < ApiController
    def index
      @user = User.find(params[:user_id])
    end

    def show
      @purchase = Purchase.find(params[:id])
    end

    def create
      @user = User.find(params[:user_id])
      @purchase = Purchase.new(user: @user)
      @purchase.save
      #if not @user.carts.empty?
      purchased = false
      @user.carts.each do |c|
        pp = PurchaseProduct.new
        product = c.product
        if product.update(stock: product.stock - c.amount)
          purchased = true
          pp.amount = c.amount
          pp.product_id = c.product_id
          pp.purchase = @purchase
          pp.save
          c.destroy
        end
      end
      if not purchased
        @purchase.destroy
        render json: { errors: @cart.errors }, status: :unprocessable_entity
      end
    end
  end
end
