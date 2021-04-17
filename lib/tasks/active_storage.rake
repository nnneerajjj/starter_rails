# frozen_string_literal: true

namespace :active_storage do
  desc 'Update CORS settings for Active Storage S3 bucket'
  task update_cors: :environment do
    # Start by getting reference to `service` which will load the corresponding
    # service class e.g. `ActiveStorage::Service::S3Service`
    service = ActiveStorage::Blob.service

    begin
      s3_class = ActiveStorage::Service.const_get(:S3Service)
    rescue NameError
      raise 'S3Service class not loaded - aborting'
    end
    raise 'Active Storage is not using S3Service - aborting' unless service.is_a?(s3_class)

    puts 'Existing CORS Rules:', service.bucket.cors.cors_rules
    service.bucket.cors.put(
      cors_configuration: {
        cors_rules: [
          {
            allowed_headers: %w[*],
            allowed_methods: %w[GET PUT],
            allowed_origins: %w[*]
          }
        ]
      }
    )
    puts 'Updated CORS Rules:', service.bucket.cors.cors_rules
  rescue StandardError => e
    puts e.message
  end
end
