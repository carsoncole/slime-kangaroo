require "application_system_test_case"

#TODO Images should be added to product listings
class PublicPagesTest < ApplicationSystemTestCase
  test "visiting root and visiting all public pages" do
    visit root_url
    assert_selector '#home-page-logo'

    within '.footer' do
      click_on 'About'
    end
    assert_selector 'h1', text: 'About'

    within '.footer' do
      click_on 'Contact'
    end
    assert_selector 'h1', text: 'Contact'

    within '#main-nav' do
      click_on 'brand-logo'
    end
    assert_selector '#home-page-logo'
  end

  test "sending a Contact message" do
    visit root_url
    within '.footer' do
      click_on 'Contact'
    end

    fill_in 'Email', with: Faker::Internet.email
    fill_in 'message_content', with: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4)
    click_on 'Send'
    assert_text 'Thanks for the message! We will get back to you shortly.'
  end
end
