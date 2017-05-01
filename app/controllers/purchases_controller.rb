class PurchasesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @purchase = Purchase.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @purchase = Purchase.new(user: @user)
    @purchase.save
    @user.carts.each do |c|
      pp = PurchaseProduct.new
      pp.amount = c.amount
      pp.product_id = c.product_id
      pp.purchase = @purchase
      pp.save
      c.destroy
    end
    redirect_to @user
  end
end
