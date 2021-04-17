# frozen_string_literal: true

require 'rails_helper'
require 'airborne'
require 'stripe_mock'

RSpec.describe 'API::V1::users#update', type: :request do
  let(:endpoint) { api_v1_user_path('my') }

  context 'when updating is successful' do
    let(:user) { FactoryBot.create(:user) }
    let(:new_first_name) { 'Arjun' }

    before do
      sign_in user
      put endpoint,
          headers: json_auth_headers,
          params: {
            user: {
              first_name: new_first_name
            }
          }.to_json
    end

    it { expect_status :ok }

    it 'updates the attributes based off the given params' do
      user.reload
      expect(user.first_name).to eq(new_first_name)
    end
  end

  context 'when required params are missing' do
    before do
      sign_in
      put endpoint,
          headers: json_auth_headers,
          params: {
              user: {
                  first_name: nil
              }
          }.to_json
    end

    it { expect_status :unprocessable_entity }

    it 'returns the errors for the missing params' do
      expect_json_types(errors: :object, message: :string)
      expect_json(errors: { first_name: ["can't be blank"] }, message: "First name can't be blank")
    end
  end

  describe 'updating password' do
    let(:current_password) { 'password' }
    let(:user) { FactoryBot.create(:user, password: current_password) }

    context 'when current_password param is present' do
      before do
        sign_in user
        put endpoint,
            headers: json_auth_headers,
            params: {
                user: {
                    password: 'new.password', password_confirmation: 'new.password', current_password: current_password
                }
            }.to_json
      end

      it { expect_status :ok }
      it 'destroys any existing auth_tokens' do
        expect(user.authentication_tokens.count).to eq(0)
      end
    end

    context 'when current_password param is missing' do
      before do
        sign_in
        put endpoint,
            headers: json_auth_headers,
            params: {
                user: {
                    password: 'new.password', password_confirmation: 'new.password'
                }
            }.to_json
      end

      it { expect_status :unprocessable_entity }

      it 'returns the errors for the missing param' do
        expect_json_types(errors: :object, message: :string)
        expect_json(errors: { current_password: ["can't be blank"] }, message: "Current password can't be blank")
      end
    end

    context 'when the user is not authenticated' do
      it_behaves_like 'an unauthenticated request', :put, '/api/v1/users/my'
    end
  end
end
