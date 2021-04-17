# frozen_string_literal: true

module API
  module V1
    class InstallationsController < ApplicationController
      load_and_authorize_resource

      before_action :find_or_build_installation, only: :create

      def index; end

      # POST /api/v1/installations
      def create
        if @installation.save
          head :no_content
        else
          render_errors @installation
        end
      end

      private

      def find_or_build_installation
        @installation = Installation.find_or_initialize_by(create_params)
        @installation.user_id = current_user.id
      end

      def create_params
        params.require(:installation).permit(:token)
      end
    end
  end
end
