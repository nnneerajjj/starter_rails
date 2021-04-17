# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  def reset_success; end

  protected

  def after_resetting_password_path_for(_resource)
    users_password_reset_success_path
  end
end
