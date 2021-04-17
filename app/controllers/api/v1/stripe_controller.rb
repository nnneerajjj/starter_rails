# frozen_string_literal: true

module API
  module V1
    class StripeController < ApplicationController
      load_and_authorize_resource class: false

      # POST /api/v1/stripe/ephemeral_key
      def ephemeral_key
        ephemeral_key = Stripe::EphemeralKey.create(
            { customer: current_user.profile.stripe_customer_id },
            stripe_version: params['api_version']
          )
        render json: ephemeral_key.to_json, status: :created
      end

      # GET /api/v1/stripe/auth_url
      def auth_url
        profile = current_user.profile
        phone_number = profile.phone_number.gsub(/\D/, '')
        base_url = Rails.env.production? ? request.base_url : "http://#{ENV['DOMAIN']}"
        uri = URI('https://connect.stripe.com/express/oauth/authorize')
        uri.query = URI.encode_www_form(
            redirect_uri: "#{base_url}/stripe/callback",
            client_id: ENV['STRIPE_CLIENT_ID'],
            'stripe_user[business_type]': params[:business_type],
            scope: 'read_write',
            state: profile.id,
            'stripe_user[email]': current_user.email,
            'stripe_user[phone_number]': phone_number
          )
        render plain: uri.to_s
      end
    end
  end
end
