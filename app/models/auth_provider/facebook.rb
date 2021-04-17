# frozen_string_literal: true

module AuthProvider
  class Facebook < AuthProvider::Base
    def initialize(params)
      super(params)
      @graph = Koala::Facebook::API.new(@access_token)
    end

    def authenticate
      @profile = @graph.get_object('me?fields=id,first_name,last_name,name,email')
      true
    rescue StandardError
      false
    end

    def formatted_user_data
      {
          provider:    @provider,
          token:       @access_token,
          uid:         @profile['id'],
          first_name:  @profile['first_name'],
          last_name:   @profile['last_name'],
          name:        @profile['name'],
          email:       @profile['email']
      }
    end
  end
end
