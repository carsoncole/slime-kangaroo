require "test_helper"

class SetttingsControllerTest < ActionDispatch::IntegrationTest
  test "should get about_me" do
    get setttings_about_me_url
    assert_response :success
  end
end
