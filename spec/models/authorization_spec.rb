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

require 'rails_helper'

RSpec.describe Authorization, type: :model do
  subject(:authorization) { FactoryBot.build(:authorization) }

  it 'is valid with valid attributes' do
    expect(authorization).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
