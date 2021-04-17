# frozen_string_literal: true

# == Schema Information
#
# Table name: authorizations
#
#  id         :bigint(8)        not null, primary key
#  provider   :string
#  uid        :string
#  token      :string
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_authorizations_on_provider_and_uid  (provider,uid) UNIQUE
#  index_authorizations_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :authorization do
    provider { 'provider' }
    uid { 'uid' }
    token { 'token' }
    user
  end
end
