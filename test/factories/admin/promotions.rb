FactoryBot.define do
  factory :promotion, class: 'Admin::Promotion' do
    code { "Promo50" }
    name { '50% off promotion' }
    starts_at { Time.now }
    ends_at { Time.now + 7.days }

    factory :discount_promotion do
      discount_percentage { 50 }
    end

    factory :dollar_promotion do
      discount_percentage { 10 }
    end

    factory :free_shipping_promotion do
      has_free_shipping { true }
    end
  end
end
