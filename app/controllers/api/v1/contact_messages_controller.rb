# frozen_string_literal: true

module API
  module V1
    class ContactMessagesController < ApplicationController
      skip_before_action :authenticate!
      load_and_authorize_resource

      # POST /api/v1/contact_messages
      #
      # @contact_message is automatically initialized by CanCanCan using contact_message_params.
      # See https://github.com/CanCanCommunity/cancancan/wiki/Strong-Parameters
      def create
        return render_errors(@contact_message) unless @contact_message.valid?

        AdminMailer.with(contact_message: @contact_message).contact_message.deliver
        render json: { message: 'Sent contact message' }
      end

      private

      def contact_message_params
        params.require(:contact_message).permit(:first_name, :last_name, :email, :reason, :message)
      end
    end
  end
end
