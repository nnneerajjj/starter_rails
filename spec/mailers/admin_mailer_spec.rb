# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'mail with correct admin headers' do
  it 'renders the to/from headers' do
    expect(mail.to).to eq(admins.map(&:email))
    expect(mail[:from].value).to eq(ENV['EMAIL_FROM_ADDRESS'])
  end
end

RSpec.describe AdminMailer, type: :mailer do
  let!(:admins) { FactoryBot.create_list(:admin, 2) } # rubocop:disable RSpec/LetSetup

  describe 'contact_message' do
    let(:contact_message) { FactoryBot.build(:contact_message) }
    let(:mail) { AdminMailer.with(contact_message: contact_message).contact_message }

    it_behaves_like 'mail with correct admin headers'

    it 'renders the subject' do
      expect(mail.subject).to eq('New Contact Message')
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include(
        *%i[first_name last_name email reason message]
            .map { |m| CGI.escapeHTML(contact_message.method(m).call) }
      )
    end
  end
end
