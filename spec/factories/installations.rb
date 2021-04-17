# frozen_string_literal: true

# == Schema Information
#
# Table name: installations
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_installations_on_user_id            (user_id)
#  index_installations_on_user_id_and_token  (user_id,token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :installation do
    user
    token { Faker::Crypto.sha256 } # 64 chars
  end
end
