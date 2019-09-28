class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def create
    product = Product.new(product_hash)
    if product.save
      redirect_to("index")
    end
  end

  private

  def create_params
    params.permit(:asin)
  end

  def product_hash
    @product_hash ||= ScraperService.new(asin: create_params[:asin]).scrape
  end
end
