class OrderMailer < ApplicationMailer
  SUBJECT_CONFIRM = 'Email confirm'.freeze
  SUBJECT_CONFIRM = 'Email confirm'.freeze
  def email_confirmation(email, order)
    @order = order
    mail(to: email, subject: SUBJECT_CONFIRM)
  end

  def email_clear(email, order)
   @order = order
   mail(to: email, subject: SUBJECT_CONFIRM)
 end
end
