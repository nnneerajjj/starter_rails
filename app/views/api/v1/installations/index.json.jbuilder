# frozen_string_literal: true

json.installations do
  json.array! @installations, partial: 'api/v1/installations/installation', as: :installation
end
