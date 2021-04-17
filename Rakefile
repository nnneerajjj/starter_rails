# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# Clear the asset_host before precompilation to avoid URL issues.
# See https://stackoverflow.com/q/57758632/956688
Rake::Task['assets:precompile'].enhance %i[clear_asset_host]
