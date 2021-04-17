# frozen_string_literal: true

require 'rails_helper'
require 'airborne'

RSpec.describe 'API::V1::sessions#destroy', type: :request do
  context 'when user is authenticated' do
    before do
      sign_in
      delete destroy_api_v1_user_session_path, headers: auth_headers
    end

    it { expect_status :no_content }
  end
end
