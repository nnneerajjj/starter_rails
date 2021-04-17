# frozen_string_literal: true

class ContactMessage
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :email, :reason, :message

  validates :first_name, :last_name, :reason, :message, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
