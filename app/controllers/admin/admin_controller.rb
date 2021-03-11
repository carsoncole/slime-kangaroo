class Admin::AdminController < ApplicationController
  include Clearance::Controller
  before_action :require_login
  before_action :require_admin

  def require_admin
    unless current_user && current_user.is_admin?
      redirect_to root_path
    end
  end
end
