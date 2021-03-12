require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "thanks_for_your_order" do
    user = create(:user)
    mail = UserMailer.with(user: user).thanks_for_your_order
    assert_equal "Thanks for your order", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["slimekangaroo@gmail.com"], mail.from
    assert_match "Thanks for your order", mail.body.encoded
  end

  # test "your_order_has_been_shipped" do
  #   user = create(:user)
  #   mail = UserMailer.with(user: user).your_order_has_been_shipped
  #   assert_equal "Your order has been shipped", mail.subject
  #   assert_equal [user.email], mail.to
  #   assert_equal ["slimekangaroo@gmail.com"], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end

end
