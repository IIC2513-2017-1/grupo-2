module Api::V1
  class PurchasesController < ApiController
    before_action :authenticate

    def index
      unless (@current_user.id == params[:user_id]) || (@current_user.role.name == "admin")
        render( json: {} ) and return
      end
      @user = User.find(params[:user_id])
    end

    def show
      unless (@current_user.id == params[:user_id]) || (@current_user.role.name == "admin")
        render( json: {} ) and return
      end
      @purchase = Purchase.find(params[:id])
    end

    def create
      unless (@current_user.id == params[:user_id]) || (@current_user.role.name == "admin")
        render( json: {} ) and return
      end
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
