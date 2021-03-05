require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Amount", with: @order.amount
    fill_in "Cancelled at", with: @order.cancelled_at
    fill_in "City", with: @order.city
    fill_in "Country", with: @order.country
    fill_in "Date", with: @order.date
    fill_in "Email", with: @order.email
    fill_in "Received at", with: @order.received_at
    fill_in "Refunded at", with: @order.refunded_at
    fill_in "Shipped at", with: @order.shipped_at
    fill_in "State", with: @order.state
    fill_in "Street address 1", with: @order.street_address_1
    fill_in "Street address 2", with: @order.street_address_2
    fill_in "Zip", with: @order.zip
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @order.amount
    fill_in "Cancelled at", with: @order.cancelled_at
    fill_in "City", with: @order.city
    fill_in "Country", with: @order.country
    fill_in "Date", with: @order.date
    fill_in "Email", with: @order.email
    fill_in "Received at", with: @order.received_at
    fill_in "Refunded at", with: @order.refunded_at
    fill_in "Shipped at", with: @order.shipped_at
    fill_in "State", with: @order.state
    fill_in "Street address 1", with: @order.street_address_1
    fill_in "Street address 2", with: @order.street_address_2
    fill_in "Zip", with: @order.zip
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
