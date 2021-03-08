require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "successfully deleting a product when its not in any orders" do
    product = create(:product)

    assert_difference('Product.count', -1) do
      product.destroy
    end
  end

  test "failing deleting a product it exists in orders" do
    product = create(:product)
    order = create(:order)
    create(:order_item, product: product, order: order)

    assert_difference('Product.count', 0) do
      product.destroy
    end
  end
end
