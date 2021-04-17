# frozen_string_literal: true

class AuthController < ActionController::Base
  include ErrorHandler

  protect_from_forgery with: :exception,
                       unless: proc { |controller| controller.request.format.json? }

  rescue_from CanCan::AccessDenied do |exception|
    sign_out @current_user
    redirect_to '/users/sign_in', alert: exception.message
  end
end
