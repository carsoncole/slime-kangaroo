require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { amount: @order.amount, cancelled_at: @order.cancelled_at, city: @order.city, country: @order.country, date: @order.date, email: @order.email, received_at: @order.received_at, refunded_at: @order.refunded_at, shipped_at: @order.shipped_at, state: @order.state, street_address_1: @order.street_address_1, street_address_2: @order.street_address_2, zip: @order.zip } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { amount: @order.amount, cancelled_at: @order.cancelled_at, city: @order.city, country: @order.country, date: @order.date, email: @order.email, received_at: @order.received_at, refunded_at: @order.refunded_at, shipped_at: @order.shipped_at, state: @order.state, street_address_1: @order.street_address_1, street_address_2: @order.street_address_2, zip: @order.zip } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
