FactoryBot.define do
  factory :product_category do
    product #deixando assim sempre que eu gerar uma factory de product category, ele vai gerar um product
    category
  end
end
