# frozen_string_literal: true

json.extract! user, :id, :first_name, :last_name, :email, :status
json.profile_picture user.profile_picture.attached? ? rails_blob_url(user.profile_picture) : nil
