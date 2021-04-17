# frozen_string_literal: true

class StripeController < AuthController
  # GET /stripe/callback
  def callback
    redirect_to "railsstarterbackend://stripe?code=#{params[:code]}"
  end
end
