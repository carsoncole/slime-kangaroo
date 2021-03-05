FactoryBot.define do
  factory :order_item do
    order_id { "" }
    product_id { 1 }
    quantity { 1 }
    unit_price { "9.99" }
    amount { "9.99" }
  end
end
