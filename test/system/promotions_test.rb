require "application_system_test_case"

class PromotionsTest < ApplicationSystemTestCase
  setup do
    @promotion = promotions(:one)
  end

  test "visiting the index" do
    visit promotions_url
    assert_selector "h1", text: "Promotions"
  end

  test "creating a Promotion" do
    visit promotions_url
    click_on "New Promotion"

    fill_in "Code", with: @promotion.code
    fill_in "Discount percentage", with: @promotion.discount_percentage
    fill_in "End", with: @promotion.end
    fill_in "Name", with: @promotion.name
    fill_in "Start", with: @promotion.start
    click_on "Create Promotion"

    assert_text "Promotion was successfully created"
    click_on "Back"
  end

  test "updating a Promotion" do
    visit promotions_url
    click_on "Edit", match: :first

    fill_in "Code", with: @promotion.code
    fill_in "Discount percentage", with: @promotion.discount_percentage
    fill_in "End", with: @promotion.end
    fill_in "Name", with: @promotion.name
    fill_in "Start", with: @promotion.start
    click_on "Update Promotion"

    assert_text "Promotion was successfully updated"
    click_on "Back"
  end

  test "destroying a Promotion" do
    visit promotions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Promotion was successfully destroyed"
  end
end
