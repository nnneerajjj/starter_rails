# frozen_string_literal: true

desc 'Clear the Action Controller asset_host'
task :clear_asset_host do
  Rails.configuration.action_controller.asset_host = nil
end
