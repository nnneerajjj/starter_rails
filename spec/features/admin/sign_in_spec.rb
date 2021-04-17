# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin signing in', type: :feature do
  let(:password) { 'password' }

  context 'when successful' do
    let(:user) { FactoryBot.create(:user, password: password, role: :admin) }

    it 'navigates to the dashboard' do
      visit '/users/sign_in'

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password

      find('input[name=commit]').click

      expect(page).to have_content 'Rails Starter'
    end
  end

  context 'when unsuccessful' do
    let(:user) { FactoryBot.create(:user, password: password, role: :user) }

    context 'and when the user is not an admin' do
      it 'displays unauthorized error' do
        visit '/users/sign_in'

        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: password

        find('input[name=commit]').click

        expect(page).to have_content 'You are not authorized to access this page.'
      end
    end

    context 'and when invalid credentials are provided' do
      it 'displays unauthorized error' do
        visit '/users/sign_in'

        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: 'fake_password'

        find('input[name=commit]').click

        expect(page).to have_content 'Invalid email or password.'
      end
    end
  end
end
