class ProductsController < ApplicationController
  # before_filter :authorize # For now we are not restricting any pages
  
  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
  end

end
