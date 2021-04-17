# frozen_string_literal: true

types_path = Rails.root.join('lib', 'rails_admin', 'config', 'fields', 'types')
require Rails.root.join(types_path, 'array')
require Rails.root.join(types_path, 'citext')

RailsAdmin.config do |config|
  config.main_app_name = 'Rails Starter'

  config.parent_controller = 'AuthController'

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'Admin', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.excluded_models = %w[AuthenticationToken Authorization Installation]
end
