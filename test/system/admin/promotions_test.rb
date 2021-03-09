require "application_system_test_case"

class Admin::PromotionsTest < ApplicationSystemTestCase
  setup do
    @admin_promotion = admin_promotions(:one)
  end

  test "visiting the index" do
    visit admin_promotions_url
    assert_selector "h1", text: "Admin/Promotions"
  end

  test "creating a Promotion" do
    visit admin_promotions_url
    click_on "New Admin/Promotion"

    fill_in "Code", with: @admin_promotion.code
    fill_in "Discount percentage", with: @admin_promotion.discount_percentage
    fill_in "End", with: @admin_promotion.end
    fill_in "Name", with: @admin_promotion.name
    fill_in "Start", with: @admin_promotion.start
    click_on "Create Promotion"

    assert_text "Promotion was successfully created"
    click_on "Back"
  end

  test "updating a Promotion" do
    visit admin_promotions_url
    click_on "Edit", match: :first

    fill_in "Code", with: @admin_promotion.code
    fill_in "Discount percentage", with: @admin_promotion.discount_percentage
    fill_in "End", with: @admin_promotion.end
    fill_in "Name", with: @admin_promotion.name
    fill_in "Start", with: @admin_promotion.start
    click_on "Update Promotion"

    assert_text "Promotion was successfully updated"
    click_on "Back"
  end

  test "destroying a Promotion" do
    visit admin_promotions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Promotion was successfully destroyed"
  end
end
