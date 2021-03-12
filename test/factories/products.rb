FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    is_active { true }
    size_oz { 6 }
  end
end
