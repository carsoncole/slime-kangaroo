require "application_system_test_case"

#TODO Need coupon tests
#TODO Images should be added to product listings
class OrdersTest < ApplicationSystemTestCase
  # setup do
  #   @product = create(:product, is_active: true)
  # end

  # test "visiting the index" do
  #   visit orders_url
  #   assert_selector "h1", text: "Orders"
  # end

  test "creating a Order" do
    product = create(:product, is_active: true)
    visit root_url
    click_on product.name
    click_on 'Add to Cart'

    assert_text "continue shopping"
  end

  test "cart" do
    active_products = create_list(:product, 10)
    in_active_products = create_list(:product, 3, is_active: false)

    visit root_url
    assert_selector '.product-listing', count: 10


    # Add items to cart
    click_on active_products[3].name
    click_on 'Add to Cart'
    assert_link active_products[3].name
    click_on 'continue shopping'

    click_on active_products[4].name
    click_on 'Add to Cart'
    click_on active_products[4].name
    click_on 'Add to Cart'

    assert_selector '#cart-table', count: 1
    assert_selector '#cart-table tr', count: 4
    assert_selector "#cart-table tr#product#{active_products[3].id} td.quantity", text: '1'
    assert_selector "#cart-table tr#product#{active_products[4].id} td.quantity", text: '2'

    # Remove an item from cart
    assert_button 'Remove', count: 2
    click_on "remove-button-#{active_products[3].id}"
    assert_no_link active_products[3].name # check that the item has been removed
    assert_selector '#cart-table tr', count: 3

    # calculate gross total
    assert_selector '#gross-amount', text: (active_products[4].price * 2).to_s
  end

  test "checkout" do
    product = create(:product)
    visit root_url
    click_on product.name
    click_on 'Add to Cart'
    click_on 'Proceed to Checkout'
    assert_text 'Please register or sign in to continue.'

    within '#sign-up' do
      assert_difference('User.count') do
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: Faker::Internet.password
        click_on 'Register'
      end
    end

    assert_selector 'h1', text: 'Shipping'
    assert_link 'continue shopping'

    fill_in 'order_addressee', with: Faker::Name.name
    fill_in 'order_street_address_1', with: Faker::Address.street_address
    fill_in 'order_city', with: Faker::Address.city
    all('#state-dropdown option')[1].select_option
    fill_in 'order_zip_code', with: Faker::Address.zip_code

    click_on 'Continue'

    assert_selector 'h1', text: 'Review Order'
    assert_button 'Payment'
  end

  # test "updating a Order" do
  #   visit orders_url
  #   click_on "Edit", match: :first

  #   fill_in "Amount", with: @order.amount
  #   fill_in "Cancelled at", with: @order.cancelled_at
  #   fill_in "City", with: @order.city
  #   fill_in "Country", with: @order.country
  #   fill_in "Date", with: @order.date
  #   fill_in "Email", with: @order.email
  #   fill_in "Received at", with: @order.received_at
  #   fill_in "Refunded at", with: @order.refunded_at
  #   fill_in "Shipped at", with: @order.shipped_at
  #   fill_in "State", with: @order.state
  #   fill_in "Street address 1", with: @order.street_address_1
  #   fill_in "Street address 2", with: @order.street_address_2
  #   fill_in "Zip", with: @order.zip
  #   click_on "Update Order"

  #   assert_text "Order was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Order" do
  #   visit orders_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Order was successfully destroyed"
  # end
end
