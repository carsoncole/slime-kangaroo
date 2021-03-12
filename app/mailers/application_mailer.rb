class ApplicationMailer < ActionMailer::Base
  before_action :set_user
  default from: "Slime Kangaroo <slimekangaroo@gmail.com>"
  layout 'mailer'

  def set_user
    if params[:user]
      @user = params[:user]
    end
  end
end
