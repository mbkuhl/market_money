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
              :vendor_count
  has_many :vendors

  attribute :vendor_count do |market|
    market.vendors.count
  end
end