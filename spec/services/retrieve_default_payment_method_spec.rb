# frozen_string_literal: true

require 'rails_helper'
require 'stripe_mock'

# TODO: Change customer, merchant to specific model names as these are just placeholders.
RSpec.describe RetrieveDefaultPaymentMethod do
  describe '#call' do
    before { StripeMock.start }

    after { StripeMock.stop }

    context 'when the profile is a Customer' do
      # See customer_spec's describe("#default_payment_method")
      pending
    end

    context 'when the profile is a Merchant' do
      # let(:profile) { FactoryBot.create(:merchant) }
      # let(:service) { RetrieveDefaultPaymentMethod.new(profile) }

      # it { expect(service.call).to be_nil }
      pending
    end
  end
end
