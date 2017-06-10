class PurchasesController < ApplicationController
  include Registered

  before_action :logged_in?
  before_action :admin?, only: [:destroy, :confirm, :index]
  before_action :set_purchase, only: [:show, :destroy, :confirm]
  before_action :set_current_user, only: [:create]

  def index
    @purchases = Purchase.pending
  end

  def show
    permitted_user? @purchase
  end

  def create
    @purchase = Purchase.new(user: current_user)
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
    else
      @admin = Role.find_by_name("admin").users.last
      UserMailer.admin_purchase_email(@admin, @user, @purchase).deliver_later
      UserMailer.purchase_email(@user, @purchase).deliver_later
    end
    redirect_to @user
  end

  def destroy
    user = @purchase.user
    @purchase.purchase_products.destroy_all
    @purchase.destroy
    redirect_to user
  end

  def confirm
    respond_to do |format|
      if @purchase.payment_confirmed && @purchase.update(payment_confirmed: false)
        format.html {redirect_to @purchase, notice: "Purchase was succesfully edited."}
        format.json {
          render json: {
            unconfirmed: {
              id: @purchase.id
            }
          }
        }
      elsif @purchase.update(payment_confirmed: true)
        format.html {redirect_to @purchase, notice: "Purchase was succesfully edited."}
        format.json {
          render json: {
            confirmed: {
              id: @purchase.id
            }
          }
        }
      end
    end
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def set_current_user
    @user = current_user
  end
end
