# frozen_string_literal: true

# == Schema Information
#
# Table name: authentication_tokens
#
#  id           :bigint(8)        not null, primary key
#  body         :string
#  user_id      :bigint(8)
#  last_used_at :datetime
#  ip_address   :string
#  user_agent   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  expires_in   :integer
#
# Indexes
#
#  index_authentication_tokens_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :authentication_token do
    body { 'body' }
    user
    last_used_at { '2017-07-07 14:01:59' }
    ip_address { 'ip' }
    user_agent { 'user_agent' }
  end
end
