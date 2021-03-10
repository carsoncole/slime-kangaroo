FactoryBot.define do
  factory :order_item do
    product
    quantity { 1 }
    item_type { 'Product' }
    unit_price { product.price }
  end
end
