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

require 'rails_helper'

RSpec.describe AuthenticationToken, type: :model do
  subject(:authentication_token) { FactoryBot.build_stubbed(:authentication_token) }

  it 'is valid with valid attributes' do
    expect(authentication_token).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
