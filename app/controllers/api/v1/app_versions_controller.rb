# frozen_string_literal: true

module API
  module V1
    class AppVersionsController < ApplicationController
      skip_before_action :authenticate!

      def show
        @app_version = AppVersion.last
      end
    end
  end
end
