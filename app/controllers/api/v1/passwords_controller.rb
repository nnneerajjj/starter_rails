# frozen_string_literal: true

module API
  module V1
    class PasswordsController < Devise::PasswordsController
      # Removes password nesting on parameters passed in
      # i.e. { password: { user: { email: 'email@email.com'} } } >> { user: { email: 'email@email.com' } }
      def resource_name
        :user
      end
    end
  end
end
