FactoryBot.define do
  factory :coupon do
    name { "MyString" }
    code { Faker::Commerce.unique.promotion_code(digits: 6) }
    status { %I(active inactive).sample }
    discount_value { rand(1..99) }
    max_use { 1 }
    due_date { "2022-03-10 15:38:55" }
  end
end
