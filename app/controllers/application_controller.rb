# FIXME Users can access all controllers/actions which should be restricted
class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :set_cart_order

  def set_cart_order
    @cart_order = Order.find_by(id: cookies[:order_id])
  end
end
