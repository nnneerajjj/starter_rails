# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples_for 'authorizable' do
  let(:klass_name) { described_class.to_s }
  let(:klass_sym) { klass_name.underscore.to_sym }
  let(:klass) { Object.const_get(klass_name) }

  describe 'associations' do
    it { is_expected.to have_many(:authorizations).dependent(:destroy) }
  end

  describe '.from_auth' do
    let(:params) do
      {
          provider: 'facebook',
          uid: 'fake_uid',
          token: 'fake_token',
          name: 'First Last'
      }
    end

    describe 'auth scenarios' do
      context 'when an authorization exists that matches params' do
        let!(:current_user) { FactoryBot.create(klass_sym) }
        let!(:authorization) do
          FactoryBot.create(:authorization,
                            provider: 'facebook',
                            uid: 'fake_uid')
        end

        context 'and it belongs to the current_user' do
          before { authorization.update(user: current_user) }

          after { authorization.update(user: nil) }

          let(:model) { klass.from_auth(params, current_user) }

          it { expect(model).to eq(current_user) }
        end

        context 'and it does not belong to the current_user' do
          let(:model) { klass.from_auth(params, current_user) }

          it { expect(model).not_to eq(current_user) }
          it { expect(model).to be_nil }
        end
      end

      context 'when no authorization exists' do
        context 'and there is a current_user' do
          let!(:current_user) { FactoryBot.create(klass_sym) }
          let(:model) { klass.from_auth(params, current_user) }

          it 'creates an Authorization with the current_user' do
            expect(model).to eq(current_user)
            expect(Authorization.where(user: current_user, provider: 'facebook', uid: 'fake_uid').first).not_to be_nil
          end
        end

        context 'when params[:email] is present' do
          let(:email) { 'test@gmail.com' }

          before { params.except!(:email).merge!(email: email) }

          after { params.except!(:email) }

          context 'and a user exists that matches email' do
            let!(:user) { FactoryBot.create(klass_sym, email: email) }
            let(:model) { klass.from_auth(params, nil) }

            it { expect(model).to eq(user) }

            it 'creates an Authorization with the user' do
              expect(model).to eq(user)
              expect(Authorization.where(user: user, provider: 'facebook', uid: 'fake_uid').first).not_to be_nil
            end
          end

          context 'and a user does not exist that matches email' do
            let(:model) { klass.from_auth(params, nil) }

            it 'creates a new user' do
              expect(model).not_to be_nil
              expect(model.class).to eq(klass)
            end

            it 'creates a new Authorization' do
              expect(Authorization.where(user: model, provider: 'facebook', uid: 'fake_uid').first).not_to be_nil
            end
          end
        end
      end
    end

    describe 'setting name' do
      context 'when first and last params are provided' do
        before do
          params.except!(:name, :first_name, :last_name).merge!(
              first_name: 'First',
              last_name: 'Last'
            )
        end

        let(:model) { klass.from_auth(params, nil) }

        it { expect(model.first_name).to eq('First') }
        it { expect(model.last_name).to eq('Last') }
      end

      context 'when name param is provided' do
        before do
          params.except!(:name, :first_name, :last_name).merge!(
              name: 'First Last'
            )
        end

        let(:model) { klass.from_auth(params, nil) }

        it { expect(model.first_name).to eq('First') }
        it { expect(model.last_name).to eq('Last') }
      end
    end
  end
end
