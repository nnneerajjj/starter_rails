# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactMessage, type: :model do
  subject(:contact_message) { FactoryBot.build(:contact_message) }

  it 'is valid with valid attributes' do
    expect(contact_message).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:reason) }
    it { is_expected.to validate_presence_of(:message) }
  end
end
