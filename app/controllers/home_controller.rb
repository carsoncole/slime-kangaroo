class HomeController < ApplicationController
  def index
    @products = Product.active.limit(3)
    @home_page_introduction = Setting.first.home_page_introduction if Setting.first
  end

  def about
    @about_me = Setting.first.about_me if Setting.first
  end
end
