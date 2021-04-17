# frozen_string_literal: true

# == Schema Information
#
# Table name: app_versions
#
#  id           :bigint(8)        not null, primary key
#  version      :string
#  force_update :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AppVersion < ApplicationRecord
end
