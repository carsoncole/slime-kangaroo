class Admin::OrdersController < Admin::AdminController
  before_action :set_order, only: %i[ show edit update destroy ]

  def index
    @orders = Order.order(created_at: :desc)
  end

  def destroy
    if @order.destroy
      redirect_to admin_orders_url, notice: "Order was successfully destroyed." 
    else
      redirect_to admin_orders_url, notice: "Only orders that have a status of 'Shopping' may be destroyed."
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:date, :shipped_at, :cancelled_at, :refunded_at, :email, :street_address_1, :street_address_2, :city, :state, :zip_code, :country, :addressee)
    end
end
