# frozen_string_literal: true

class AdminMailer < ApplicationMailer
  def self.admin_emails
    User.admin.pluck(:email)
  end

  # Subject is set in config/locales/en.yml with the following lookup:
  #
  #   en.admin_mailer.contact_message.subject
  #
  def contact_message
    @contact_message = params[:contact_message]
    mail to: self.class.admin_emails
  end
end
