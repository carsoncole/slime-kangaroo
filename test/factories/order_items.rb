FactoryBot.define do
  factory :order_item do
    product { product }
    quantity { 1 }
  end
end
