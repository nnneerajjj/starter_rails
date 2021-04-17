# frozen_string_literal: true

Rails.application.config.generators do |generate|
  generate.helper false
  generate.assets false
  generate.view_specs false
  generate.controller_specs false
  generate.template_engine :jbuilder
  generate.test_framework :rspec
end
