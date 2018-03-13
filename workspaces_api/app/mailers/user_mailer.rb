class UserMailer < ApplicationMailer
  SUBJECT_CONFIRM = 'Email confirm'.freeze
  SUBJECT_RESET_PASSWORD = 'Email reset password'.freeze
  def email_confirmation(user)
    @user = user
    @user.update(confirm_send: Time.now)
    mail(to: user.email, subject: SUBJECT_CONFIRM)
  end

  def email_reset_password(user)
    @user = user
    mail(to: user.email, subject: SUBJECT_RESET_PASSWORD)
  end
end
