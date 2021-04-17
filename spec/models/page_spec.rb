# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id          :bigint(8)        not null, primary key
#  title       :string
#  description :text
#  user_id     :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_pages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Page, type: :model do
  subject(:page) { FactoryBot.build(:page) }

  it 'is valid with valid attributes' do
    expect(page).to be_valid
  end

  describe 'associations' do
    it { belong_to(:user) }
  end
end
