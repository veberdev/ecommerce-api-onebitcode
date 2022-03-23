FactoryBot.define do
  factory :coupon do
    code { Faker::Commerce.unique.promotion_code(digits: 6) }
    status { %I(active inactive).sample }
    discount_value { rand(1..99) }
    max_use { 1 }
    due_date { Time.zone.now + 1.day }
  end
end
