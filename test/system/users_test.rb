require "application_system_test_case"

#TODO Images should be added to product listings
class UsersTest < ApplicationSystemTestCase
  test "logging in" do
    user = create(:user)
    visit root_url
    click_on 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within '#sign-in' do
      click_on 'Sign in'
    end
    within '#main-nav' do
      assert_link 'Sign out'
    end
  end

  test 'user logging in and viewing their account' do
    sign_in

    # Create an order that has been charged
    order_item = create(:order_item)
    order = order_item.order
    order.update(user: @user)
    order_item_2 = create(:order_item, order: order)
    order.update(charged_at: Time.now)

    within '#main-nav' do
      click_on 'Account'
    end

    assert_selector 'h2', text: 'Orders'
    assert_selector 'table.table#orders-table'
  end
end
