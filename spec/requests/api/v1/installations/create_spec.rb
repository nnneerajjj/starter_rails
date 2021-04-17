# frozen_string_literal: true

require 'rails_helper'
require 'airborne'

RSpec.describe 'API::V1::installations#create', type: :request do
  context 'when user is authenticated' do
    context 'and when the installation token has not been used' do
      before do
        sign_in
        post api_v1_installations_path,
             headers: json_auth_headers,
             params: {
                 installation: {
                     token: 'token'
                 }
             }.to_json
      end

      it { expect_status :no_content }
    end

    context 'and when the installation token has been used' do
      let(:user) { FactoryBot.create(:user) }
      let(:token) { 'token' }
      let(:installation) { FactoryBot.create(:installation, token: token) }
      let!(:installation_user) { installation.user }

      before do
        sign_in user
        post api_v1_installations_path,
             headers: json_auth_headers,
             params: {
                 installation: {
                     token: token
                 }
             }.to_json
      end

      it { expect_status :no_content }

      it 'no longer belongs to the original installation owner' do
        installation.reload
        expect(installation.user).not_to eq(installation_user)
      end

      it 'belongs to the current_user' do
        installation.reload
        expect(installation.user).to eq(user)
      end
    end

    context 'when required params are missing' do
      before do
        sign_in
        post api_v1_installations_path,
             headers: json_auth_headers,
             params: {
                 installation: {
                     token: nil
                 }
             }.to_json
      end

      it { expect_status :unprocessable_entity }

      it 'returns the errors for the missing params' do
        expect_json_types(errors: :object, message: :string)
        expect_json(errors: { token: ["can't be blank"] }, message: "Token can't be blank")
      end
    end
  end

  context 'when the user is not authenticated' do
    it_behaves_like 'an unauthenticated request', :post, '/api/v1/installations'
  end
end
