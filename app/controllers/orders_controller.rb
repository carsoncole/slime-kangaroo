class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    if @order.update(order_params)
      redirect_to checkout_path
    else
      render :edit, status: :unprocessable_entity
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
    if signed_in? && @order && @order.user_id.nil?
      @order.update(user: current_user)
    elsif signed_in? && @order&.user != current_user
      cookies.delete(:order_id)
    end
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
    order.destroy if order.order_items.empty?
    redirect_to cart_path
  end

  def shipping
    @order = Order.find_by(id: cookies[:order_id])
    if signed_in? && @order.user_id.nil?
      @order.update(user: current_user)
    elsif signed_in? && @order.user != current_user
      cookies.delete(:order_id)
    end

    @order.addressee = @order.user.name unless @order.addressee
    @order.street_address_1 = @order.user.street_address_1 unless @order.street_address_1
    @order.street_address_2 = @order.user.street_address_2 unless @order.street_address_2
    @order.city = @order.user.city unless @order.city
    @order.state = @order.user.state unless @order.state
    @order.zip_code = @order.user.zip_code unless @order.zip_code
    render layout: 'checkout'
  end

  def checkout
    @order = Order.find_by(id: cookies[:order_id])
    render layout: 'checkout'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:date, :amount, :received_at, :shipped_at, :cancelled_at, :refunded_at, :email, :street_address_1, :street_address_2, :city, :state, :zip_code, :country, :addressee)
    end
end
