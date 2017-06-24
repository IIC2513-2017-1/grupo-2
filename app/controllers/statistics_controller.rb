class StatisticsController < ApplicationController
  include Registered

  before_action :logged_in?
  before_action :admin?

  def index
    @categories = Category.all
    @category_names = @categories.pluck("name")
    @category_product_amounts = @categories.map {|category| category.product_amount}
    @category_money_amounts = @categories.map {|category| category.money_amount}
    @month_names = []
    @month_spendings = []
    date = DateTime.new(DateTime.now.year, DateTime.now.month) - 12.months
    12.times do
      @month_names << date.strftime("%Y - %m")
      @month_spendings << Purchase.where("created_at >= ? AND created_at < ?", date, date + 1.months).sum(&:get_total)
      date += 1.months
    end
  end

end
