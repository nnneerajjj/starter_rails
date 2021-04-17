# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize:

module API
  module V1
    class RegistrationsController < Devise::RegistrationsController
      before_action :configure_permitted_parameters

      # POST /resource
      def create
        ActiveRecord::Base.transaction do
          build_resource(sign_up_params)
          resource.save
          yield resource if block_given?

          unless resource.persisted?
            clean_up_passwords resource
            set_minimum_password_length
            return render_errors(resource)
          end

          if resource.active_for_authentication?
            sign_up(resource_name, resource)
          else
            expire_data_after_sign_in!
          end

          # @token = Tiddle.create_and_return_token(resource, request, expires_in: 1.week)
          @user = resource

          # TODO: Keep/remove code below if payment processing is needed
          # begin
          #   CreateStripeCustomer.new(resource.profile).call!
          # rescue => e
          #   render_errors(e.message)
          #   raise ActiveRecord::Rollback
          # end

          @tokens = AuthenticationToken.create_tokens(
            user: @user,
            user_agent: request.user_agent,
            remote_ip: request.remote_ip
          )
        end
      end

      # PUT /resource
      def update
        ActiveRecord::Base.transaction do
          self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
          resource_updated = update_resource(resource, account_update_params)
          yield resource if block_given?

          return render_errors(resource) unless resource_updated

          bypass_sign_in resource, scope: resource_name
          @token = request.headers['X-USER-TOKEN']
          @user = resource

          # TODO: Keep/remove code below if payment processing is needed
          # begin
          #   CreateStripeCustomer.new(resource.profile).call!
          # rescue => e
          #   render_errors(e.message)
          #   raise ActiveRecord::Rollback
          # end
        end
      end

      # GET /email_available
      def email_available
        email = params[:email]
        if current_user&.email != email && User.exists?(email: email)
          render_errors('Email has already been taken', :conflict)
        else
          head :no_content
        end
      end

      protected

      def configure_permitted_parameters
        param_keys = %i[first_name last_name provider email profile_picture]
        devise_parameter_sanitizer.permit(:sign_up, keys: param_keys)
        devise_parameter_sanitizer.permit(:account_update, keys: param_keys)
      end

      def update_resource(resource, params)
        params[:password].present? ? resource.update_with_password(params) : resource.update_without_password(params)
      end

      def resource_name
        :user
      end
    end
  end
end

# rubocop:enable Metrics/AbcSize:
