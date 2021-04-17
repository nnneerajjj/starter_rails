# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/admin
class AdminPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/admin/contact_message
  def contact_message
    contact_message = FactoryBot.build(:contact_message)
    AdminMailer.with(contact_message: contact_message).contact_message
  end
end
