class CategoriesController < ApplicationController
  # before_filter :authorize # For now we are not restricting any pages

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
  end

end
