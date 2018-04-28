class User < ApplicationRecord
  has_many :workspaces
  has_many :orders
  has_many :favorites
  has_many :comments
  has_secure_password validations: false
  enum role: %w[user partner admin]

  validates :email, presence: true, uniqueness: true

  def send_activation_email
    UserMailer.email_confirmation(self).deliver_now
  end

  def active_email?
    if confirm_send + 2.days >= Time.now
      update(confirm_at: Time.now)
    else
      new_email_token = SecureRandom.hex(8)
      update(confirm_token: new_email_token)
      false
    end
  end

  def send_resetpassword_email
    UserMailer.email_reset_password(self).deliver_now
  end

  def reset_password_token
    token = SecureRandom.hex(3)
    update(password_reset_token: token)
  end
end
