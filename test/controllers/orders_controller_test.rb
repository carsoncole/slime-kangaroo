require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should show cart" do
    get cart_url
    assert_response :success
  end

  test "should add an item to cart, create order, order item" do
    product = create(:product)
    assert_difference('Order.count') do
      assert_difference('OrderItem.count', 3) do
        post add_to_cart_path, params: { product_id: product.id }
      end
    end

    assert_redirected_to cart_url
  end

  test "should remove an item from cart" do
    product = create(:product)
    product_2 = create(:product)

    post add_to_cart_path, params: { product_id: product.id }
    post add_to_cart_path, params: { product_id: product_2.id }

    assert_difference('OrderItem.count', -1) do
      post remove_from_cart_path, params: { product_id: product.id }
    end

    assert_difference('OrderItem.count', -3) do
      post remove_from_cart_path, params: { product_id: product_2.id }
    end

    assert_redirected_to cart_url
  end

  test "should remove last item from cart and destroy order" do
    product = create(:product)
    product_2 = create(:product)

    post add_to_cart_path, params: { product_id: product.id }
    post add_to_cart_path, params: { product_id: product_2.id }

    assert_difference('OrderItem.count', -1) do
      post remove_from_cart_path, params: { product_id: product.id }
    end

    assert_equal 1, Order.count

    assert_difference('Order.count', -1) do
      assert_difference('OrderItem.count', -3) do
        post remove_from_cart_path, params: { product_id: product_2.id }
      end
    end

    assert_redirected_to cart_url
  end

  test "checkout for unregisterd shopper" do
    post add_to_cart_path, params: { product: create(:product)}
    get shipping_url
    assert_redirected_to sign_in_url
  end

  test "checkout and register as a user and assign user to order" do
    post add_to_cart_path, params: { product: create(:product)}
    get shipping_url
    assert_redirected_to sign_in_url
    assert_difference('User.count') do
      post users_path, params: { user: { email: Faker::Internet.email, password: 'password' } }
    end
    assert_redirected_to shipping_url
    # OPTIMIZE Requesting checkout_url seems duplicative here but is required
    get shipping_url
    assert_equal User.last, Order.last.reload.user

    post orders_path, params: { order: { addressee: Faker::Name.name, street_address_1: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code } }

  end
end
