FactoryBot.define do
  factory :message do
    email { Faker::Internet.email }
    content { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end
