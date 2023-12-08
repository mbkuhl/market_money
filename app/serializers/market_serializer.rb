class MarketSerializer
  include JSONAPI::Serializer
  attributes  :name,
              :street,
              :city,
              :county,
              :state,
              :zip,
              :lat,
              :lon,
              :vendor_count,
              :cash_only
  has_many :vendors

  attribute :vendor_count do |market|
    market.vendors.count
  end

  attribute :cash_only do |market|
    market.vendors.all? { |vendor| !vendor.credit_accepted }
  end
end