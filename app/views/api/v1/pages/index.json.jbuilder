# frozen_string_literal: true

json.array! @pages.each do |page|
  json.partial! 'api/v1/pages/page', page: page
end
