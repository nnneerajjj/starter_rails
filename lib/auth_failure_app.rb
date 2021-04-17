# frozen_string_literal: true

class AuthFailureApp < Devise::FailureApp
  protected

  def http_auth_body
    { errors: [i18n_message], message: i18n_message }.to_json
  end
end
