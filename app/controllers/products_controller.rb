class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def create
    product = Product.new(product_hash)
    if product.save
      flash[:notice] = "Product successfully saved!"
      redirect_back(fallback_location: products_url)
    else
      flash[:alert] = "Sorry, we can't locate this product"
      redirect_back(fallback_location: products_url)
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
