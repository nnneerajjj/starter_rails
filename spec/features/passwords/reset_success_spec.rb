# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User resetting their password', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    raw, enc = Devise.token_generator.generate(user.class, :reset_password_token)
    user.reset_password_token   = enc
    user.reset_password_sent_at = Time.now.utc
    user.save(validate: false)

    visit "/users/password/edit?locale=en&redirect_url=&reset_password_token=#{raw}"

    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'

    find('input[name=commit]').click
  end

  it 'resets successfully' do
    expect(page).to have_content 'Password Reset Successful!'
    expect(page).to have_content 'Please navigate back to the app to sign in.'
  end
end
