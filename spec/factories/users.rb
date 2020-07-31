FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "test#{n + 1}" }
    sequence(:password) { |n| "test#{n + 1}" }
    sequence(:email) { |n| "test#{n + 1}@test.com" }
    sequence(:first_name) { |n| "first#{n + 1}" }
    sequence(:last_name) { |n| "last#{n + 1}" }
  end
end
