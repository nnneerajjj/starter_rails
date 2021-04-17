# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['EMAIL_FROM_ADDRESS']
  layout 'mailer'
end
