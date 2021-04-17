# frozen_string_literal: true

FactoryBot.define do
  factory :contact_message do
    transient do
      user { FactoryBot.build_stubbed(:user) }
    end

    first_name { user.first_name }
    last_name { user.last_name }
    email { user.email }
    reason { Faker::Lorem.word }
    message { Faker::Lorem.paragraph }
  end
end
