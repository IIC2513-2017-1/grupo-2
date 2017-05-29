class UsersController < ApplicationController
  include Registered

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user, only: :show_cart
  before_action :logged_in?, only: [:index, :show, :edit, :update, :destroy, :show_cart,
                                    :add_to_cart, :destroy_cart]
  before_action :admin?, only: [:index]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    same_user? @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    same_user? @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver_later
        format.html { redirect_to root_path, notice: 'Account created. You may now login.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    same_user? @user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    same_user? @user
    if current_user.role.name == "admin" && current_user.id == @user.id
      redirect_to users_path, notice: "You can't delete an admin account from that same account." and return
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_cart
    render "carts/index"
  end

  def add_to_cart

    @cart = Cart.new(cart_params)
    same_user? @cart.user
    if @cart.update_if_similar || @cart.save
      redirect_to cart_path
    else
      redirect_to product_path(cart_params[:product_id]),
        alert: "Amount must be specified and a positive whole number"
    end
  end

  def destroy_cart
    @cart = Cart.find(params[:id])
    same_user? @cart.user
    @cart.destroy
    redirect_to cart_path
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Your email has been confirmed."
      redirect_to new_session_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_current_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :email, :password_confirmation)
    end

    def cart_params
      params.require(:cart).permit(:product_id, :amount).merge(user_id: current_user.id)
    end
end
