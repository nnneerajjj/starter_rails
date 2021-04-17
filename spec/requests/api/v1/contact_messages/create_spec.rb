# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a failed ContactMessages create response' do
  it { expect_status :unprocessable_entity }

  it 'does not send an email' do
    expect(AdminMailer.deliveries.count).to eq(0)
  end
end

RSpec.shared_examples 'a successful ContactMessages create response' do
  let(:message_contents) do
    params
      .fetch_values(:first_name, :last_name, :email, :reason, :message)
      .map { |p| CGI.escapeHTML(p) }
  end

  it { expect_status :ok }

  it 'returns a confirmation message' do
    expect_json_types(message: :string)
    expect_json(message: 'Sent contact message')
  end

  it 'sends an email to admins with message info' do
    deliveries = AdminMailer.deliveries
    expect(deliveries.count).to eq(1)
    message = deliveries.first

    expect(message.body.encoded).to include(*message_contents)
  end
end

RSpec.shared_examples 'a ContactMessages create endpoint' do
  context 'and required params are missing' do
    let(:params) { { first_name: Faker::Name.first_name, message: Faker::Lorem.paragraph } }
    let(:error_response) do
      {
        errors: {
          last_name: ["can't be blank"],
          email: ["can't be blank", 'is invalid'],
          reason: ["can't be blank"]
        },
        message: "Last name can't be blank / Reason can't be blank / Email can't be blank / Email is invalid"
      }
    end

    it_behaves_like 'a failed ContactMessages create response'

    it 'returns errors for the missing params' do
      expect_json_types(errors: :object, message: :string)
      expect_json(error_response)
    end
  end

  context 'and an invalid email is provided' do
    let(:params) { FactoryBot.attributes_for(:contact_message, email: 'invalid') }

    it_behaves_like 'a failed ContactMessages create response'

    it 'returns errors for the invalid email' do
      expect_json_types(errors: :object, message: :string)
      expect_json(
        errors: { email: ['is invalid'] },
        message: 'Email is invalid'
      )
    end
  end

  context 'and required params are provided' do
    let(:params) { FactoryBot.attributes_for(:contact_message) }

    it_behaves_like 'a successful ContactMessages create response'
  end
end

RSpec.describe 'API::V1::ContactMessages#create', type: :request do
  # Create an admin to send emails to
  before { FactoryBot.create(:admin) }

  context 'when the user is not authenticated' do
    before do
      post api_v1_contact_messages_path, headers: json_headers, params: params.to_json
    end

    it_behaves_like 'a ContactMessages create endpoint'
  end

  context 'when the user is authenticated' do
    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in user
      post api_v1_contact_messages_path, headers: json_auth_headers, params: params.to_json
    end

    it_behaves_like 'a ContactMessages create endpoint'
  end
end
