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

end
