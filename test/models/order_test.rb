require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "successfully deleting an order when status is 'Shopping'" do
    user = create(:user)
    order = create(:order, user: user)
    assert_equal 'Shopping', order.status

    assert_difference('Order.count', -1) do
      order.destroy
    end
  end

  test "failing deleting an order when status is NOT 'Shopping'" do
    user = create(:user)
    order = create(:order, user: user, charged_at: Time.now)
    assert_equal 'Fulfillment', order.status

    assert_difference('Order.count', 0) do
      order.destroy
    end
  end

  test "status required presence" do
    order = create(:order)
    assert order.status

    order.status = nil
    assert order.valid?
  end

  test "order has a gros and net value" do
    order = create(:order)
    total = 0
    item = create(:order_item, order: order)
    total += item.quantity * item.unit_price
    assert_equal total, order.reload.gross_amount

    item = create(:order_item, order: order)
    total += item.quantity * item.unit_price
    item = create(:order_item, order: order)
    total += item.quantity * item.unit_price
    assert_equal total, order.reload.gross_amount

    assert_equal total, order.net_amount
  end

  test "taxes are calculated for only WA" do
    user = create(:user_with_address, state: 'WA')
    order = create(:order, user: user)

    item = create(:order_item, order: order)
    assert item.amount, order.gross_amount
    assert order.gross_amount * 0.09, order.order_items.taxes.first.amount
    assert order.net_amount, (order.gross_amount * 1.09) + order.shipping.amount

    order.update(state: 'VA')
    assert order.net_amount, order.gross_amount + order.shipping.amount
  end

  test "statuses" do
    order = create(:order)
    assert_equal 'Shopping', order.status

    order.update(charged_at: Time.now)
    assert_equal 'Fulfillment', order.status

    order.update(cancelled_at: Time.now)
    assert_equal 'Cancelled', order.status
  end
end
