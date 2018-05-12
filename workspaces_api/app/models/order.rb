class Order < ApplicationRecord
  belongs_to :user
  belongs_to :workspace
  belongs_to :workspace_type
  enum status: %w[waiting accept clear]

  def self.send_confirm_order_email(email, order)
    OrderMailer.email_confirmation(email, order).deliver_now
  end

  def self.send_clear_order_email(email, order)
    OrderMailer.email_clear(email, order).deliver_now
  end
end
