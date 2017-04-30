class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :create]
  before_action :set_product

  # GET /products/1/comments
  # GET /products/1/comments.json
  def index
    @comments = @product.comments
  end

  # GET /products/1/comments/1
  # GET /products/1/comments/1.json
  def show
  end

  # GET /products/1/comments/new
  def new
    @comment = Comment.new
    @comment.product = @product
    @comment.user = @user
  end

  # GET /products/1/comments/1/edit
  def edit
  end

  # POST /products/1/comments
  # POST /products/1/comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.product = @product
    @comment.user = @user


    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@product, @comment], notice: 'Comment was successfully created.' }
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
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@product, @comment], notice: 'Comment was successfully updated.' }
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
      format.html { redirect_to product_comments_url(@product), notice: 'Comment was successfully destroyed.' }
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

    def set_user
      @user = User.find(1)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
