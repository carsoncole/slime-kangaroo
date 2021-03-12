ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require 'clearance/test_unit'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  def sign_in(user = nil)
    @user = user || create(:user)
    visit sign_in_url
    within '#sign-in' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on 'Sign in'
    end
  end

  def sign_up
    within '#sign-up' do
      assert_difference('User.count') do
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: Faker::Internet.password
        click_on 'Register'
      end
    end
    @user = User.last
  end


  def fill_in_shipping_address
    fill_in 'order_addressee', with: Faker::Name.name
    fill_in 'order_street_address_1', with: Faker::Address.street_address
    fill_in 'order_city', with: Faker::Address.city
    all('#state-dropdown option')[1].select_option
    fill_in 'order_zip_code', with: Faker::Address.zip_code
  end

end
