class StatisticsController < ApplicationController
  include Registered

  before_action :logged_in?
  before_action :admin?

  def index
    @categories = Category.all
    @category_names = @categories.pluck("name")
    @category_product_amounts = @categories.map {|category| category.product_amount}
    @category_money_amounts = @categories.map {|category| category.money_amount}
  end

end
