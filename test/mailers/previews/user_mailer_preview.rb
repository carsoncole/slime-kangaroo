# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/thanks_for_your_order
  def thanks_for_your_order
    UserMailer.thanks_for_your_order
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/your_order_has_been_shipped
  def your_order_has_been_shipped
    UserMailer.your_order_has_been_shipped
  end

end
