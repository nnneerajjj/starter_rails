# frozen_string_literal: true

Koala.configure do |config|
  config.app_id = ENV['FACEBOOK_APP_ID']
  config.app_secret = ENV['FACEBOOK_APP_SECRET']
  config.api_version = ENV['FACEBOOK_VERSION']
end
