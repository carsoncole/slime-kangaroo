require 'json'
class ChargesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    session = Stripe::Checkout::Session.create({
      customer_email: current_user.email,
      shipping_address_collection: {
        allowed_countries: ['US', 'CA'],
      },
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          unit_amount: (@cart_order.amount*100).to_i,
          currency: 'usd',
          product_data: {
            name: 'Slime Kangaroo',
          },
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: "http://localhost:3000/charges/success.html?order_id=#{@cart_order.id}",
      cancel_url: 'http://localhost:3000/charges/cancel.html',
    })

    render json: { id: session.id }
  end

  def stripe_webhook
    event = Stripe::Event.retrieve(params[:id])
    StripeCharge.new(event).process
    render nothing: true, status: 201
  rescue Stripe::APIConnectionError, Stripe::StripeError
    render nothing: true, status: 400
  end

  def success
    order = Order.find_by(id: params[:order_id])
    order.update(charged_at: Time.now) if order
  end

  def cancel
  end
end
