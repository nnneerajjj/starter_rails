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

class AuthenticationToken < ApplicationRecord
  belongs_to :user

  def self.create_tokens(user:, user_agent:, remote_ip:)
    user.authentication_tokens.where(user_agent: user_agent, ip_address: remote_ip).destroy_all

    access_token = Auth.access_token(user_id: user.id)
    refresh_token = Auth.refresh_token(user_id: user.id)

    user.authentication_tokens.create([
                                        { body: access_token, user_agent: user_agent, ip_address: remote_ip },
                                        { body: refresh_token, user_agent: user_agent, ip_address: remote_ip }
                                      ])

    { access_token: access_token, refresh_token: refresh_token }
  end
end
