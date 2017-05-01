class PurchasesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
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
      product = Product.find(c.product_id)
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
    end
    redirect_to @user
  end
end
