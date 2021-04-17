# frozen_string_literal: true

# require 'rails_helper'
# require 'airborne'
# require 'stripe_mock'
#
# describe 'API::V1::stripe#ephemeral_key', type: :request do
#   context 'when user is authenticated' do
#     let(:ephemeral_key_json) do
#       {
#           id: 'ephkey_123',
#           object: 'ephemeral_key',
#           associated_objects: [
#             { id: 'cus_123', type: 'customer' }
#           ],
#           created: 1_508_957_636,
#           expires: 1_508_961_236,
#           livemode: false,
#           secret: 'ek_test_123'
#       }
#     end
#     let(:user) { FactoryBot.create(:customer, stripe_customer_id: 'cus_1').user }
#
#     after { StripeMock.stop }
#
#     before do
#       StripeMock.start
#       expect(Stripe::EphemeralKey).to receive(:create).and_return(ephemeral_key_json)
#
#       sign_in user
#       post api_v1_stripe_ephemeral_key_path,
#            headers: json_auth_headers,
#            params: { api_version: '1.0' }.to_json
#     end
#
#     it { expect_status :ok }
#     it { expect_json(ephemeral_key_json) }
#   end
#
#   context 'when user is not authenticated' do
#     before { post api_v1_stripe_ephemeral_key_path }
#
#     it { expect_status :unauthorized }
#   end
# end
