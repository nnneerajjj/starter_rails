# frozen_string_literal: true

require 'rails_helper'
require 'airborne'

RSpec.describe 'API::V1::pages#index', type: :request do
  context 'and pages are visible' do
    let!(:pages) { FactoryBot.create_list(:page, 4) }

    describe 'GET /pages' do
      before do
        get api_v1_pages_path
      end

      it 'works!' do
        expect(response).to have_http_status(:ok)
      end

      it { expect_json_types('*', page_json_types) }
      it { expect_json(pages.map { |page| page_json(page) }) }
      it { expect_json_sizes(4) }
    end
  end
end
