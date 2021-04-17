# frozen_string_literal: true

# require 'rails_helper'
# require 'airborne'
#
# RSpec.describe 'API::V1::sessions#authenticate', type: :request do
# context 'when authentication is successful' do
#   before do
#     facebook_attributes.merge(name: 'First Last', email: 'test@gmail.com')
#     stub_koala_client!
#     post api_v1_users_authenticate_path,
#          headers: json_headers,
#          params: { provider: 'facebook', access_token: 'access_token' }.to_json
#   end
#
#   it { expect_status :ok }
#   it {
#     expect_json_types(
#         user: user_json_types,
#         auth_token: :string
#       )
#   }
#
#   it { expect_json(user: user_json(User.last)) }
# end
#
# context 'when authorization is already in use by another user' do
#   let(:uid) { 'fake_uid' }
#
#   before do
#     FactoryBot.create(:authorization, provider: 'facebook', uid: uid)
#     sign_in
#     facebook_attributes.merge(id: uid)
#     stub_koala_client!
#     post api_v1_users_authenticate_path,
#          headers: json_auth_headers,
#          params: { provider: 'facebook', access_token: 'access_token' }.to_json
#   end
#
#   it { expect_status :unprocessable_entity }
#   it { expect_json_types(message: :string) }
#   it { expect_json(message: 'This facebook account is used already.') }
# end
#
# context 'when an API error occurs' do
#   before do
#     sign_in
#     stub_koala_client_with_error!
#     post api_v1_users_authenticate_path,
#          headers: json_headers,
#          params: { provider: 'facebook', access_token: 'access_token' }.to_json
#   end
#
#   it { expect_status :unprocessable_entity }
#   it { expect_json_types(message: :string) }
#   it { expect_json(message: 'There was an error with facebook. Please try again.') }
# end
# end
