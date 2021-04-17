# frozen_string_literal: true

module API
  module V1
    class UsersController < ApplicationController
      # GET /api/v1/users/current_user
      def current
        current_user
      end

      def update
        return render_errors(current_user) unless update_user(current_user, update_params)
      end

      protected

      def update_params
        param_keys = %i[first_name last_name provider email current_password password password_confirmation
                        profile_picture]
        # devise_parameter_sanitizer.permit(:account_update, keys: param_keys)
        params.require(:user).permit(param_keys)
      end

      def update_user(user, params)
        params[:password].present? ? user.update_with_password(params) : user.update_without_password(params)
      end
    end
  end
end
