# frozen_string_literal: true

require 'jwt'

class Auth
  ALGORITHM = 'HS256'
  ACCESS_TOKEN_EXPIRY_DURATION = 30.minutes
  REFRESH_TOKEN_EXPIRY_DURATION = 1.day
  TOKEN_LEEWAY_DURATION = 10

  def self.access_token(payload)
    issue(
      data: payload,
      exp: (Time.zone.now + ACCESS_TOKEN_EXPIRY_DURATION).to_i
    )
  end

  def self.refresh_token(payload)
    issue(
      refresh_data: payload,
      exp: (Time.zone.now + REFRESH_TOKEN_EXPIRY_DURATION).to_i
    )
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, auth_secret, ALGORITHM)
    decoded_token.first['exp'] < Time.now.to_i - TOKEN_LEEWAY_DURATION ?
      nil :
      decoded_token.first
  rescue StandardError
    nil
  end

  def self.issue(payload)
    JWT.encode(payload, auth_secret, ALGORITHM)
  end

  def self.auth_secret
    ENV['ENCRYPTOR_KEY']
  end
end
