# FIXME Users can access all controllers/actions which should be restricted
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :set_cart_order

  def set_cart_order
    if cookies[:order_id]
      @cart_order = Order.find_by(id: cookies[:order_id], charged_at: nil)
      cookies.delete(:order_id) unless @cart_order
    end
  end
end
