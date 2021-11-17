class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.thanks_for_your_order.subject
  #
  def thanks_for_your_order
    mail to: @user.email, subject: 'Thanks for your order'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.your_order_has_been_shipped.subject
  #
  def your_order_has_been_shipped
    mail to: @user.email, subject: 'Your order has been shipped'
  end
end
