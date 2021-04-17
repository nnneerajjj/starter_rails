# frozen_string_literal: true

json.user { json.partial! 'api/v1/users/user', user: @user }
json.auth_token @tokens[:access_token]
json.refresh_token @tokens[:refresh_token]
