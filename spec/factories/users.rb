# frozen_string_literal: true

FactoryBot.define do
  factory :user do

    factory :valid_user, parent: :user do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
    end

    factory :user_without_email, parent: :user do
      password { Faker::Internet.password }
    end
  end
end
