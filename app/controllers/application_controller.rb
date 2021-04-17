# frozen_string_literal: true

class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  include ErrorHandler

  before_action :authenticate!

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_errors(exception.message, :not_found)
  end

  rescue_from CanCan::AccessDenied do |exception|
    render_errors(exception.message, :forbidden)
  end

  def authenticate!
    render_errors('You need to Sign in to access this action', :unauthorized) if current_user.nil?
  end

  def current_user
    @current_user ||= verify_token if decoded_token.present?
  end

  def decoded_token
    return if request_token.blank?

    Auth.decode(request_token)
  end

  def request_token
    return unless request.env.fetch('HTTP_AUTHORIZATION', '')
                         .scan(/Bearer/).flatten.first

    request.env['HTTP_AUTHORIZATION'].scan(/Bearer(.*)$/).flatten.last.strip
  end

  def verify_token
    user = User.find_by!(id: decoded_token['data']['user_id'])
    user if user.tokens.include?(request_token)
  end
end
