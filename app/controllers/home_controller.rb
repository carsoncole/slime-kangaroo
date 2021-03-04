class HomeController < ApplicationController
  def index
    @products = Product.active.limit(3)
  end

  def about
  end
end
