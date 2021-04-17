# frozen_string_literal: true

require 'rails_helper'
require 'airborne'

RSpec.describe 'API::V1::sessions#create', type: :request do
  let!(:user) { FactoryBot.create(:user, email: 'test@gmail.com', password: 'password') }

  context 'when authentication is successful' do
    before do
      post api_v1_user_session_path,
           params: { user: { email: 'test@gmail.com', password: 'password' } }
    end

    it { expect_status :ok }
    it {
      expect_json_types(
          user: user_json_types,
          auth_token: :string,
          refresh_token: :string
        )
    }

    it { expect_json(user: user_json(user)) }
  end

  context 'when an authentication token for user+IP+user_agent already exists' do
    before do
      FactoryBot.create(:authentication_token, user: user, ip_address: '127.0.0.1', user_agent: nil)
      post api_v1_user_session_path,
           params: { user: { email: 'test@gmail.com', password: 'password' } }
    end

    it 'destroys all existing tokens with same user+agent+IP' do
      expect(user.authentication_tokens.count).to eq(2)
    end
  end

  context 'when password is invalid' do
    before do
      post api_v1_user_session_path,
           params: { user: { email: 'test@gmail.com', password: 'wrong-password' } }
    end

    it { expect_status :unauthorized }

    it 'returns the errors for the invalid password' do
      expect_json(message: 'Invalid email or password')
    end
  end
end
