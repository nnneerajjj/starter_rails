# frozen_string_literal: true

json.user { json.partial! 'api/v1/users/user', user: current_user }
