# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { "1a#{Faker::Internet.password(min_length: 6)}" }
    password_confirmation { password }
    profile { 'プロフィール' }
    after(:build) do |user|
      user.avatar.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
