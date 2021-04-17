# frozen_string_literal: true

json.user { json.partial! 'api/v1/users/user', user: @user }
json.auth_token @token
