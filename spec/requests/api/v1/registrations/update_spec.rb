# frozen_string_literal: true

# require 'rails_helper'
# require 'airborne'
# require 'stripe_mock'
#
# RSpec.describe 'API::V1::registrations#update', type: :request do
#   context 'when updating is successful' do
#     let(:user) { FactoryBot.create(:user) }
#     let(:new_email) { 'new.email@gmail.com' }
#
#     before do
#       sign_in user
#       put api_v1_user_registration_path,
#           headers: json_auth_headers,
#           params: {
#               user: {
#                   email: new_email
#               }
#           }.to_json
#     end
#
#     it { expect_status :ok }
#
#     it 'updates the attributes based off the given params' do
#       user.reload
#       expect(user.email).to eq(new_email)
#     end
#   end
#
#   context 'when required params are missing' do
#     before do
#       sign_in
#       put api_v1_user_registration_path,
#           headers: json_auth_headers,
#           params: {
#               user: {
#                   first_name: nil
#               }
#           }.to_json
#     end
#
#     it { expect_status :unprocessable_entity }
#
#     it 'returns the errors for the missing params' do
#       expect_json_types(errors: :object, message: :string)
#       expect_json(errors: { first_name: ["can't be blank"] }, message: "First name can't be blank")
#     end
#   end
#
#   describe 'updating password' do
#     let(:current_password) { 'password' }
#     let(:user) { FactoryBot.create(:user, password: current_password) }
#
#     context 'when current_password param is present' do
#       before do
#         sign_in user
#         put api_v1_user_registration_path,
#             headers: json_auth_headers,
#             params: {
#               user: {
#                 password: 'new.password', password_confirmation: 'new.password', current_password: current_password
#               }
#             }.to_json
#       end
#
#       it { expect_status :ok }
#       it 'destroys any existing auth_tokens' do
#         expect(user.authentication_tokens.count).to eq(0)
#       end
#     end
#
#     context 'when current_password param is missing' do
#       before do
#         sign_in
#         put api_v1_user_registration_path,
#             headers: json_auth_headers,
#             params: {
#                 user: {
#                     password: 'new.password', password_confirmation: 'new.password'
#                 }
#             }.to_json
#       end
#
#       it { expect_status :unprocessable_entity }
#
#       it 'returns the errors for the missing param' do
#         expect_json_types(errors: :object, message: :string)
#         expect_json(errors: { current_password: ["can't be blank"] }, message: "Current password can't be blank")
#       end
#     end
#
#     context 'when the user is not authenticated' do
#       it_behaves_like 'an unauthenticated request', :put, '/api/v1/users/'
#     end
#   end
# end
