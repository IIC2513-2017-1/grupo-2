class ProductsController < ApplicationController
  include Registered

  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:new, :edit, :create, :update, :destroy]
  before_action :admin?, only: [:new, :edit, :create, :update, :destroy]
  before_action :find_categories, only: [:create, :update]

  # GET /products
  # GET /products.json
  def index
    if params.key?(:search)
      category = Category.find(params[:search])
      @products = category.products
    else
      @products = Product.all
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @cart = Cart.new
    @comments = @product.comments
    @comment = Comment.new
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params.merge(categories: find_categories))

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|


      if @product.update(product_params.merge(categories: find_categories))

        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :image, :price, :stock, :offer, categories: [])
    end

    def find_categories
      # notice the [1..-1] part. It is there because the first element of
      # params[:product][:categories] is an empty string
      Category.find(params[:product][:categories][1..-1])
    end
end
