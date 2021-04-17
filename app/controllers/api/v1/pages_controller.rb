# frozen_string_literal: true

module API
  module V1
    class PagesController < ApplicationController
      load_resource
      skip_before_action :authenticate!

      def index; end
    end
  end
end
