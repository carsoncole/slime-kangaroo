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
end
