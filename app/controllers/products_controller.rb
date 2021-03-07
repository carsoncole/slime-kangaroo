class ProductsController < ApplicationController

  def show
    @product = Product.find(params[:id])
    @related_products = Product.where("master_product_id = ? OR id = ? OR id = ?", @product.id, @product.id, @product.master_product_id)
  end
end
