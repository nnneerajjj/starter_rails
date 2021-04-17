# frozen_string_literal: true

require 'rails_helper'
require 'airborne'

RSpec.describe 'API::V1::users#email_available', type: :request do
  let(:email) { 'test@example.com' }

  context 'when user is authenticated' do
    let(:user) { FactoryBot.create(:user, email: 'user@example.com') }

    before { sign_in user }

    context 'when the email is available' do
      before do
        get api_v1_users_email_available_path(email: email), params: {}, headers: auth_headers
      end

      it { expect_status :no_content }
    end

    context 'when the email is unavailable' do
      before do
        FactoryBot.create(:user, email: email)
        get api_v1_users_email_available_path(email: email), params: {}, headers: auth_headers
      end

      it { expect_status :conflict }
    end

    context 'when the email belongs to the user' do
      before do
        get api_v1_users_email_available_path(email: email), params: {}, headers: auth_headers
      end

      it { expect_status :no_content }
    end
  end

  context 'when user is not authenticated' do
    context 'when the email is available' do
      before do
        get api_v1_users_email_available_path(email: email)
      end

      it { expect_status :no_content }
    end

    context 'when the email is unavailable' do
      before do
        FactoryBot.create(:user, email: email)
        get api_v1_users_email_available_path(email: email)
      end

      it { expect_status :conflict }
    end
  end
end
