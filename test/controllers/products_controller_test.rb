require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should show product" do
    product = create(:product)
    get product_url(product)
    assert_response :success
  end
end
