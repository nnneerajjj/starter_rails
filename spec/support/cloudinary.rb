# frozen_string_literal: true

# RSpec.configure do |config|
#   config.before(:each) do
#     stub_request(:head, %r{https://res.cloudinary.com/#{ENV['CLOUDINARY_CLOUD']}/image/upload/v1/(.*)})
#       .with(
#             headers: {
#                 Accept: '*/*',
#                 'Accept-Encoding': 'gzip, deflate',
#                 Host: 'res.cloudinary.com'
#             }
#           )
#       .to_return(status: 200, body: '', headers: {})
#
#     stub_request(:post, "https://api.cloudinary.com/v1_1/#{ENV['CLOUDINARY_CLOUD']}/image/upload")
#       .with(
#             headers: {
#                 Accept: '*/*',
#                 'Accept-Encoding': 'gzip, deflate',
#                 Host: 'api.cloudinary.com'
#             }
#           )
#       .to_return(status: 200, body: {}.to_json, headers: {})
#
#     stub_request(:post, "https://api.cloudinary.com/v1_1/#{ENV['CLOUDINARY_CLOUD']}/image/destroy")
#       .with(
#             headers: {
#                 Accept: '*/*',
#                 'Accept-Encoding': 'gzip, deflate',
#                 Host: 'api.cloudinary.com'
#             }
#           )
#       .to_return(status: 200, body: {}.to_json, headers: {})
#   end
# end
