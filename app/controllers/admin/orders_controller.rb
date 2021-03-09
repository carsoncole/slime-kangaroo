class Admin::OrdersController < ApplicationController
  before_action :require_login
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.order(created_at: :desc)
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    if @order.destroy
      redirect_to admin_orders_url, notice: "Order was successfully destroyed." 
    else
      redirect_to admin_orders_url, notice: "Only orders that have a status of 'Shopping' may be destroyed."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:date, :shipped_at, :cancelled_at, :refunded_at, :email, :street_address_1, :street_address_2, :city, :state, :zip_code, :country, :addressee)
    end
end
