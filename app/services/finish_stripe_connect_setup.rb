# frozen_string_literal: true

class FinishStripeConnectSetup
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    return true if @user&.stripe_merchant_account_id&.present?

    stripe_connect_json
    update_profile
  end

  private

  def stripe_connect_json
    uri = URI('https://connect.stripe.com/oauth/token')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')

    request.set_form_data(
        client_secret: ENV['STRIPE_SECRET_KEY'],
        code: @params[:code],
        grant_type: 'authorization_code'
      )

    response = http.request(request)
    @stripe_connect_json = JSON.parse(response.body)
  end

  def update_profile
    @stripe_connect_json['stripe_user_id'] &&
      @user.update(stripe_merchant_account_id: @stripe_connect_json['stripe_user_id'])
  end
end
