FactoryBot.define do
  factory :item do
    name { 'サンプル商品' }
    description { 'サンプル商品の説明' }
    price { 1000 }
    category_id { 1 }
    condition_id { 1 }
    shipping_charge_id { 1 }
    prefecture_id { 1 }
    shipping_date_id { 1 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/sample.png'), filename: 'sample.png', content_type: 'image/png')
    end

    trait :sold_out do
      after(:create) do |_item|
        create(:order, :item, user: create(:user))
      end
    end
  end
end
