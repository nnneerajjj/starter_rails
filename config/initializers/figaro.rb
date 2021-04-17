# frozen_string_literal: true

Figaro.require_keys(
    'CORS_ALLOWED_ORIGINS',
    'DOMAIN',
    'EMAIL_FROM_ADDRESS',
    'FACEBOOK_APP_ID',
    'FACEBOOK_APP_SECRET',
    'FACEBOOK_VERSION',
    'STRIPE_PUBLISHABLE_KEY',
    'STRIPE_SECRET_KEY',
    'STRIPE_CLIENT_ID'
  )

if Rails.env.production?
  Figaro.require_keys(
      'APNS_BUNDLE_ID',
      'BUCKETEER_AWS_ACCESS_KEY_ID',
      'BUCKETEER_AWS_REGION',
      'BUCKETEER_AWS_SECRET_ACCESS_KEY',
      'BUCKETEER_BUCKET_NAME',
      'FRONT_END_HOST',
      'SECRET_KEY_BASE',
      'SENDGRID_USERNAME',
      'SENDGRID_PASSWORD'
    )
end
