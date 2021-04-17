# frozen_string_literal: true

Rails.application.routes.draw do
  get 'reset-password', to: 'passwords#reset', as: 'edit_user_password'

  devise_for :users, controllers: { passwords: 'passwords' }, skip: [:registrations]
  devise_scope :user do
    get '/users/password/reset_success', to: 'passwords#reset_success'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: redirect('/admin')

  post '/rails/active_storage/direct_uploads', to: 'direct_uploads#create'

  get 'stripe/callback', to: 'stripe#callback'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      devise_for :users, controllers: { sessions: 'api/v1/sessions', registrations: 'api/v1/registrations' }
      devise_scope :user do
        post '/users/authenticate', to: 'sessions#authenticate'
        get '/users/email_available', to: 'registrations#email_available'
      end

      get '/users/current_user', to: 'users#current'
      get 'stripe/auth_url', to: 'stripe#auth_url'
      post 'stripe/ephemeral_key', to: 'stripe#ephemeral_key'

      resources :installations, only: %i[index create]

      resources :contact_messages, only: %i[create]

      resources :users, only: :update

      resources :pages, only: :index
      resources :app_versions, only: :show
    end
  end
end
