require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message = build(:message)
  end

  test "should get index" do
    get contact_url
    assert_response :success
  end

  test "should create contact message" do
    assert_difference('Message.count') do
      post messages_url, params: { message: { content: @message.content, email: @message.email } }
    end

    assert_redirected_to contact_url
  end
end
