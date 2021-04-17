# frozen_string_literal: true

module RequestHelper
  def sign_in(user = nil)
    @current_user = user || FactoryBot.create(:user)
    post '/api/v1/users/sign_in', params: { user: { email: @current_user.email, password: @current_user.password } }
    @auth_headers = { 'Authorization': 'Bearer ' + json_body[:auth_token] }
  end

  def auth_headers
    @auth_headers
  end

  # See https://relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec#providing-json-data
  def json_headers
    { CONTENT_TYPE: 'application/json' }
  end

  def json_auth_headers
    { **json_headers, **auth_headers }
  end
end
