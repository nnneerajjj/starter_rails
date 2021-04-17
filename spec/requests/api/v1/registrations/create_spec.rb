# frozen_string_literal: true

require 'rails_helper'
require 'airborne'
require 'stripe_mock'

RSpec.describe 'API::V1::registrations#create', type: :request do
  let(:profile_attributes) do
    {
        phone_number: '555.555.5555',
        location_attributes: {
            city: 'Santa Monica',
            state: 'CA',
            zip: '90403',
            latitude: 34.0195,
            longitude: -118.4912
        }
    }
  end

  context 'when registration is successful' do
    before do
      post api_v1_user_registration_path,
           params: {
               user: {
                   email: 'test@gmail.com', password: 'password', password_confirmation: 'password',
                   first_name: 'First', last_name: 'Last'
               }
           }
    end

    it { expect_status :ok }
    it {
      expect_json_types(
          user: user_json_types
        )
    }

    it { expect_json(user: user_json(User.last)) }
  end

  context 'when required params are missing' do
    before do
      post api_v1_user_registration_path,
           params: {
               user: {
                   email: 'test@gmail.com', first_name: 'First', last_name: 'Last'
               }
           }
    end

    it { expect_status :unprocessable_entity }

    it 'returns the errors for the missing params' do
      expect_json_types(errors: :object, message: :string)
      expect_json(errors: { password: ["can't be blank"] }, message: "Password can't be blank")
    end
  end
end
