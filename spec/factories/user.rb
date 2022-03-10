FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    email { Faker::Internet.email }
    password { "123456"}
    password_confirmation { "123456"}
    profile { %i(admin client).sample }

  end
end

