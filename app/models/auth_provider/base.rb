# frozen_string_literal: true

module AuthProvider
  class Base
    def initialize(params)
      @provider = self.class.name.split('::').last.downcase
      @access_token = params[:access_token]
    end

    def authenticate
      false
    end
  end
end
