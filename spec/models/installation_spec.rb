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

require 'rails_helper'

RSpec.describe Installation, type: :model do
  subject(:installation) { FactoryBot.build(:installation) }

  it 'is valid with valid attributes' do
    expect(installation).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_uniqueness_of(:token).scoped_to(:user_id) }
  end

  describe 'associations' do
    it { belong_to(:user) }
  end
end
