#TODO Add user profile editing
class UsersController < Clearance::UsersController
  before_action :require_login, only: %i[ show ]

  def show
    @user = current_user
    @orders = @user.orders
  end

  def edit
    @user = current_user
  end

end
