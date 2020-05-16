FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "user#{i}@example.com" }
    password { '12334567' }
    password_confirmation { '12334567' }
  end
end