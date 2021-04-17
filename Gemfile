# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.9'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 1.0', require: 'rack/cors'

# Application configuration
gem 'figaro', '~> 1.1'

# Background Jobs
gem 'delayed_job_active_record', '~> 4.1'

# Assets
gem 'bootstrap-sass', '~> 3.4'
gem 'jquery-rails', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5.2'
gem 'uglifier', '~> 4.1'

# Authentication
gem 'devise', '~> 4.6'
gem 'devise-argon2'
gem 'devise-bootstrap-views', '~> 0.0.11'
gem 'koala', '~> 3.0'
gem 'tiddle', '~> 1.4'

# Authorization
gem 'cancancan', '~> 3.0'

# Admin Panel
gem 'rails_admin', '~> 1.4'

# Money
gem 'money-rails', '~> 1.13'
gem 'stripe', '~> 4.21'

# Push Notifications
gem 'rpush', '~> 3.0'

# Active Storage
gem 'aws-sdk-s3', '~> 1.45', require: false
gem 'mini_magick', '~> 4.9'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Slugging
gem 'friendly_id', '~> 5.2'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'annotate'
  gem 'byebug', platform: %i[mri mingw x64_mingw]
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'letter_opener'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'airborne'
  gem 'capybara', '~> 2.15'
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
  gem 'stripe-ruby-mock', require: 'stripe_mock'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# TODO
