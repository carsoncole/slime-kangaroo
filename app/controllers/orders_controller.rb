class OrdersController < ApplicationController
  before_action :require_login, only: %i[ update create shipping review]
  before_action :set_order, only: %i[ show edit update destroy ]

  def update
    if params[:order][:promo_code].present?
      if @order.apply_promo_code!(params[:order][:promo_code])
        message = 'Promo code has been applied.'
      else
        message = 'Promo code has expired or does not exist.'
      end
      redirect_to review_path, notice: message
    elsif @order.update(order_params)
      if @order.shipping_info_provided?
        redirect_to review_path
      else
        redirect_to shipping_path, notice: 'Please provide your shipping info.'
      end
    else
      render :shipping, status: :unprocessable_entity, layout: 'checkout'
    end
  end

  def create
    if order = Order.find_by(id: cookies[:order_id])
      order.update(order_params)
      redirect_to review_path
    else
      redirect_to shipping_path
    end
  end

  def cart
    @order = @cart_order
    if signed_in? && @order && @order.user_id.nil?
      current_user.orders.where(status: 'Shopping').destroy_all
      @order.update(user: current_user)
    elsif signed_in? && @order && @order&.user != current_user
      cookies.delete(:order_id)
    elsif signed_in? && current_user.shopping_order
      cookies[:order_id] = current_user.shopping_order.id
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
      order.order_items.create(product_id: params[:product_id], quantity: 1, unit_price: product.price, item_type: 'Product') if product
    end
    redirect_to cart_path
  end

  def remove_from_cart
    if order = Order.find_by(id: cookies[:order_id])
      order.order_items.where(product_id: params[:product_id]).destroy_all
    end
    if order.order_items.product.empty?
      order.destroy
    end
    redirect_to cart_path
  end

  def shipping
    @order = Order.find_by(id: cookies[:order_id])
    if @order
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
    else
      redirect_to root_path and return
    end
    render layout: 'checkout'
  end

  def review
    @order = Order.find_by(id: cookies[:order_id])
    @order.apply_shipping!
    if existing_promo_code = @order.order_items.promo&.first&.promo_code
      @order.apply_promo_code!(existing_promo_code)
    end
    @order.apply_taxes!
    render layout: 'checkout'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:date, :amount, :shipped_at, :cancelled_at, :refunded_at, :street_address_1, :street_address_2, :city, :state, :zip_code, :country, :addressee, :promo_code)
    end
end
