# frozen_string_literal: true

## Example Usage
##
## You can pass a block with the resource as a let variable to visit a member route (show, update, etc)
## The id of the resource will be replaced where the first occurrence of :id appears in the path
##
## it_behaves_like 'an unauthorized request', :get, '/api/v1/games/:id' do
##  let(:resource) { game }
## end
##
## You can also use this same approach to pass params (i.e. for a post or put request).
##
##   it_behaves_like 'an unauthorized request', :post, '/api/v1/games' do
##     let(:params) do
##       {
##           game: game_attributes
##       }
##     end
##   end
RSpec.shared_examples 'an unauthorized request' do |action, endpoint|
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in user

    resolved_endpoint = if (defined? resource) && resource.present? && endpoint.include?(':id')
                          endpoint.gsub(':id', resource.id.to_s)
                        else
                          endpoint
                        end

    args = { headers: json_auth_headers }
    args[:params] = params if defined? params

    send(action, resolved_endpoint, args)
  end

  it { expect_status :forbidden }
  it { expect_json_types(:object) }
  it { expect_json_types(message: :string) }
  it { expect_json(message: 'You are not authorized to access this page.') }
end

RSpec.shared_examples 'an unauthenticated request' do |action, endpoint|
  before { send(action, endpoint) }

  it { expect_status :unauthorized }
  it { expect_json_types(:object) }
  it { expect_json_types(message: :string) }
end
