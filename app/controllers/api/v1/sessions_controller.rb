# frozen_string_literal: true

module API
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate!, only: :create

      def create
        @user = User.find_by!(email: params[:user][:email])

        unless @user.valid_password?(params[:user][:password])
          return render_errors('Invalid email or password', :unauthorized)
        end

        @tokens = AuthenticationToken.create_tokens(
          user: @user,
          user_agent: request.user_agent,
          remote_ip: request.remote_ip
        )
      end

      def destroy
        return render_errors('Unauthorized', :unauthorized) unless current_user

        current_user.authentication_tokens.find_by!(body: request_token)&.destroy

        head :no_content
      end

      # For oAuth
      # POST /api/v1/users/authenticate
      #   @provider = "AuthProvider::#{params['provider'].titleize}".constantize.new(params)
      #   if @provider.authenticate
      #     @user = User.from_auth(@provider.formatted_user_data, current_user)
      #     if @user
      #       @token = Tiddle.create_and_return_token(@user, request, expires_in: 1.week)
      #       render :create
      #     else
      #       render_errors "This #{params[:provider]} account is used already."
      #     end
      #   else
      #     render_errors "There was an error with #{params['provider']}. Please try again."
      #   end
      # end
    end
  end
end
