FactoryBot.define do
  factory :market_vendor do
    market_id { Market.all.pluck(:id).sample }
    vendor_id { Vendor.all.pluck(:id).sample }
  end
end