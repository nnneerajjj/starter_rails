# frozen_string_literal: true
# # frozen_string_literal: true

# TODO: Change customer, merchant to specific model names as these are just placeholders.
#
# require 'rails_helper'
# require 'stripe_mock'
#
# RSpec.describe CreateStripeCustomer do
#   describe '#call!' do
#     before { StripeMock.start }
#     after { StripeMock.stop }
#
#     context 'when the profile is a Customer' do
#       let(:profile) { FactoryBot.create(:customer) }
#       let(:service) { CreateStripeCustomer.new(profile) }
#
#       context 'and when a stripe customer is created successfully' do
#         it 'updates the profile with a stripe_customer_id' do
#           service.call!
#           profile.reload
#           expect(profile.stripe_customer_id).to eq('test_cus_1')
#         end
#       end
#
#       context 'and when the stripe_customer_id is already set' do
#         before { profile.update_attributes(stripe_customer_id: 'test_cus_1') }
#         it { expect(service.call!).to be_nil }
#       end
#
#       context 'and when a stripe customer fails to create successfully' do
#         it 'fails to update the profile with a stripe_customer_id' do
#           custom_error = StandardError.new('API Error')
#           StripeMock.prepare_error(custom_error, :new_customer)
#
#           expect { service.call! }.to raise_error do |e|
#             expect(e).to be_a StandardError
#             expect(e.message).to eq('An error occurred while saving your account. Please try again!')
#
#             profile.reload
#             expect(profile.stripe_customer_id).to be_nil
#           end
#         end
#       end
#     end
#
#     context 'when the profile is a Merchant' do
#       let(:profile) { FactoryBot.create(:merchant) }
#       let(:service) { CreateStripeCustomer.new(profile) }
#
#       it { expect(service.call!).to be_nil }
#     end
#   end
# end
