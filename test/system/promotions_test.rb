require "application_system_test_case"

class PromotionsTest < ApplicationSystemTestCase

  test "applying a discount promotion code" do
    promotion = create(:discount_promotion, discount_percentage: 50)
    product = create(:product)

    visit product_url(product)
    click_on 'Add to Cart'

    click_on 'Proceed to Checkout'

    sign_up

    fill_in_shipping_address
    click_on 'Continue'

    order = @user.orders.last
    assert order.gross_amount, order.net_amount

    fill_in 'promo-code-input', with: promotion.code
    click_on 'Add Promo Code'
    save_screenshot('tmp/screenshots/review_with_discoun_applied.png')

    order.reload

    discount = (order.gross_amount * promotion.discount_percentage/100).round(2)

    assert_equal -order.promo.amount, discount
    assert_equal order.gross_amount - discount + order.shipping.amount, order.net_amount

    assert_text "Promo: #{promotion.code}"
  end

  test "applying a dollar promotion code" do
    promotion = create(:dollar_promotion, discount_dollars: 10, discount_percentage: nil)
    product = create(:product)

    visit product_url(product)
    click_on 'Add to Cart'

    click_on 'Proceed to Checkout'

    sign_up

    fill_in_shipping_address
    click_on 'Continue'

    order = @user.orders.last
    gross_amount = order.gross_amount

    fill_in 'promo-code-input', with: promotion.code
    click_on 'Add Promo Code'
    save_screenshot('tmp/screenshots/review_with_dollar_discount_applied.png')

    order.reload

    assert_equal -10, order.promo.amount
    assert_equal gross_amount - 10 + order.shipping.amount, order.net_amount
    assert_text "Promo: #{promotion.code}"
  end

  test "applying a free shipping promotion code" do
    promotion = create(:free_shipping_promotion)
    assert promotion.has_free_shipping?
    product = create(:product)

    visit product_url(product)
    click_on 'Add to Cart'

    click_on 'Proceed to Checkout'

    sign_up

    fill_in_shipping_address
    click_on 'Continue'

    order = @user.orders.last
    gross_amount = order.gross_amount

    fill_in 'promo-code-input', with: promotion.code
    click_on 'Add Promo Code'
    save_screenshot('tmp/screenshots/review_with_free_shipping applied.png')
    assert_text "Promo: #{promotion.code}"
    order.reload

    assert_equal gross_amount, order.net_amount
  end

  test "applying a discount and free shipping promotion code" do
    promotion = create(:discount_promotion, has_free_shipping: true)
    product = create(:product)

    visit product_url(product)
    click_on 'Add to Cart'

    click_on 'Proceed to Checkout'

    sign_up

    fill_in_shipping_address
    click_on 'Continue'

    order = @user.orders.last
    gross_amount = order.gross_amount

    fill_in 'promo-code-input', with: promotion.code
    click_on 'Add Promo Code'
    save_screenshot('tmp/screenshots/review_with_free_shipping_and_discount.png')

    order.reload

    discount = (order.gross_amount * promotion.discount_percentage/100).round(2)
    assert_equal -order.promo.amount, discount
    assert_equal 0, order.shipping.amount

    assert_text "Promo: #{promotion.code}"
  end
end
