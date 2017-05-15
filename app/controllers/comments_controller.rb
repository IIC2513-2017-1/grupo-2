class CommentsController < ApplicationController
  include Registered

  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_product
  before_action :logged_in?, only: [:new, :edit, :create, :update, :destroy]

  # GET /products/1/comments
  # GET /products/1/comments.json
  def index
    @comments = @product.comments
  end

  # GET /products/1/comments/new
  def new
    @comment = Comment.new
    @comment.product = @product
  end

  # GET /products/1/comments/1/edit
  def edit
    permitted_user? @comment
  end

  # POST /products/1/comments
  # POST /products/1/comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.product = @product

    respond_to do |format|
      if @comment.save
        format.html { redirect_to product_path(@product), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1/comments/1
  # PATCH/PUT /products/1/comments/1.json
  def update
    permitted_user? @comment

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @product, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1/comments/1
  # DELETE /products/1/comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @product, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id)
    end
end
