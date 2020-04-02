class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_LOGIN"], password: ENV["ADMIN_PASSWORD"]

  def show
    @products_count = Product.sum(:quantity)
    @categories_count = Category.count
  end
end
