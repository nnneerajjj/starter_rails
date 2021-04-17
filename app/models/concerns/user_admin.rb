# frozen_string_literal: true

module UserAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      exclude_fields :created_at, :updated_at, :reset_password_sent_at, :remember_created_at,
                     :sign_in_count, :last_sign_in_at, :current_sign_in_ip, :current_sign_in_at,
                     :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at,
                     :unconfirmed_email, :password, :password_confirmation, :invitation_token,
                     :invitation_created_at, :invitation_sent_at, :invitation_accepted_at,
                     :invitation_limit, :invitations_count, :installations

      object_label_method :full_name
      weight 2
    end
  end
end
