class ReportsController < ApplicationController
  def index
    @categories = Category.all.map { |category| [category.name, category.id] }
  end

  def report_by_category
    report_by_category_data = Operation.select(:'categories.name').joins(:category).where(odate: params[:start_date]..params[:end_date], cashflow: params.dig(:operation, :cashflow)).group('categories.name').sum(:amount)
    @table_data = report_by_category_data.sort_by{|c,s| s.to_i}.to_h
    @categories = report_by_category_data.map { |e| e[0] }
    @sums = report_by_category_data.map { |e| e[1] }
  end

  def report_by_dates
    report_by_dates_data = Operation.where(odate: params[:start_date]..params[:end_date], cashflow: params.dig(:operation, :cashflow), category: params.dig(:operation, :category_id)).group(:odate).sum(:amount)
    @dates = report_by_dates_data.map { |e| e[0].to_s[0, 10]}
    @sums = report_by_dates_data.map { |e| e[1].to_i}
  end
end
