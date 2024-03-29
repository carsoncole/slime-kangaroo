class HomeController < ApplicationController
  def index
    @products = Product.master.active
    @home_page_introduction = Setting.first.home_page_introduction if Setting.first
  end

  def about
    @about_me = Setting.first.about_me if Setting.first
  end

  def contact
    @message = Message.new
  end
end
