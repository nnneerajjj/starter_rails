# frozen_string_literal: true

require 'rails_helper'
require 'airborne'

RSpec.describe 'API::V1::users#current', type: :request do
  let(:user) { FactoryBot.create(:user) }

  context 'when user is authenticated' do
    before do
      sign_in user
      get api_v1_users_current_user_path, params: {}, headers: auth_headers
    end

    it { expect_status :ok }
    it { expect_json_types(user_json_types) }
    it { expect_json(user_json(user)) }
  end

  context 'when the user is not authenticated' do
    it_behaves_like 'an unauthenticated request', :get, '/api/v1/users/current_user'
  end
end
