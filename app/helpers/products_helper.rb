module ProductsHelper

  def cell_klass(product)
    product.id % 2 == 0 ? "light-cell" : "dark-cell"
  end
end
