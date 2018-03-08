class UserMailer < ApplicationMailer
  def email_confirmation(user)
    @user = user
    @user.update(confirm_send: Time.now)
    mail(to: user.email, subject: 'Email confirm')
  end

  def email_reset_password(user)
    @user = user
    mail(to: user.email, subject: 'Email reset password')
  end
end
