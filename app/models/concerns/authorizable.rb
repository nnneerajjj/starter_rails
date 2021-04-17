# frozen_string_literal: true

# Module used to authorize Users using external providers

module Authorizable
  extend ActiveSupport::Concern

  included do
    has_many :authorizations, dependent: :destroy
  end

  # Provides methods for the User model to be authorized with external providers
  module ClassMethods
    def from_auth(params, current_user)
      authorization = Authorization.find_or_initialize_by(provider: params[:provider], uid: params[:uid])
      user = user_from_auth(params, current_user, authorization)
      return unless user

      authorization.token = params[:token]
      set_name(params, user)
      user.password = Devise.friendly_token[0, 10] if user.encrypted_password.blank?

      if user.email.blank?
        user.status = :pending
        user.save(validate: false)
      else
        user.save
      end
      authorization.user ||= user
      authorization.save
      user
    end

    private

    def user_from_auth(params, current_user, authorization)
      if authorization.persisted?
        return if current_user && (current_user.id != authorization.user.id)

        authorization.user
      elsif current_user
        current_user
      elsif params[:email].present?
        User.find_or_initialize_by(email: params[:email])
      else
        User.new
      end
    end

    def set_name(params, user)
      fallback_name        = params[:name].split(' ') if params[:name]
      fallback_first_name  = fallback_name.try(:first)
      fallback_last_name   = fallback_name.try(:last)
      user.first_name    ||= (params[:first_name] || fallback_first_name)
      user.last_name     ||= (params[:last_name]  || fallback_last_name)
    end
  end
end
