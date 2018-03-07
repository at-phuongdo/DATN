class UserMailer < ApplicationMailer
  def email_confirmation(user)
    @user = user
    @user.update(confirm_send: Time.now)
    mail(to: user.email, subject: 'Email confirm')
  end
end
