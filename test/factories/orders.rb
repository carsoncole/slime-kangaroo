FactoryBot.define do
  factory :order do
    date { "MyString" }
    amount { "9.99" }
    received_at { "2021-03-05 07:56:57" }
    shipped_at { "2021-03-05 07:56:57" }
    cancelled_at { "2021-03-05 07:56:57" }
    refunded_at { "2021-03-05 07:56:57" }
    email { "MyString" }
    street_address_1 { "MyString" }
    street_address_2 { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip { "MyString" }
    country { "MyString" }
  end
end
