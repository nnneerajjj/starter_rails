# frozen_string_literal: true

require 'rails_helper'
require 'airborne'

RSpec.describe 'API::V1::passwords#create', type: :request do
  context 'when password request request is successful' do
    let(:user) { FactoryBot.create(:user) }

    before do
      post api_v1_user_password_path, params: { user: { email: user.email } }
    end

    it { expect_status :created }
  end

  context 'when required params are missing' do
    before do
      post api_v1_user_password_path, params: { user: {} }
    end

    it { expect_status :unprocessable_entity }

    it 'returns the errors for the missing params' do
      expect_json_types(errors: :object)
      expect_json(errors: { email: ["can't be blank"] })
    end
  end
end
