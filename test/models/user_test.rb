require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "successfully deleting a user when they have NO orders" do
    user = create(:user)

    assert_difference('User.count', -1) do
      user.destroy
    end
  end

  test "failing deleting a user when they HAVE orders" do
    user = create(:user)
    order = create(:order, user: user)

    assert_difference('User.count', 0) do
      user.destroy
    end
  end
end
