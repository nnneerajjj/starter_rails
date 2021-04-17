# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string
#  role                   :string           default("user"), not null
#  status                 :integer          default("active"), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'
require_relative '../../spec/concerns/authorizable'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build_stubbed(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it_behaves_like 'authorizable'

  describe 'upon initialization' do
    it { expect(user.role).to eq('user') }
    it { expect(user.status).to eq('active') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :role }
    it { is_expected.to validate_presence_of :status }
  end

  describe 'associations' do
    it { is_expected.to have_many(:authentication_tokens).dependent(:destroy) }
    it { is_expected.to have_many(:installations).dependent(:destroy) }
  end

  describe '#full_name' do
    it { expect(user.full_name).to eq("#{user.first_name} #{user.last_name}") }
  end
end
