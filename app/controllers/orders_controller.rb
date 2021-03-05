class OrdersController < ApplicationController
  before_action :require_login, except: %i[ create cart add_to_cart remove_from_cart ]
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/1/edit
  def edit
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def cart
    @order = Order.find_by(id: cookies[:order_id])
  end

  def add_to_cart
    if order = Order.find_by(id: cookies[:order_id])
    else
      order = Order.create
      cookies[:order_id] = order.id
    end
    if existing_item = order.order_items.find_by(product_id: params[:product_id])
      existing_item.update(quantity: existing_item.quantity += 1)
    else
      product = Product.find_by(id: params[:product_id])
      order.order_items.create(product_id: params[:product_id], quantity: 1, unit_price: product.price) if product
    end
    # if cookies[:cart]
    #   cart = JSON.parse(cookies[:cart])
    #   cart << params[:product_id]
    #   cookies[:cart] = JSON.generate(cart)
    # else
    #   cookies[:cart] = JSON.generate([params[:product_id]])
    # end
    redirect_to cart_path
  end

  def remove_from_cart
    if order = Order.find_by(id: cookies[:order_id])
      order.order_items.where(product_id: params[:product_id]).destroy_all
    end
    redirect_to cart_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:date, :amount, :received_at, :shipped_at, :cancelled_at, :refunded_at, :email, :street_address_1, :street_address_2, :city, :state, :zip, :country)
    end
end
