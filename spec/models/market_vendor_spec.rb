require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  describe "relationships" do
    # it { should belong_to(:market) }
    # it { should belong_to(:vendor) }
  end

  it "#uniqueness_of_relationship" do
    market = create_list(:market, 1).first
    vendor = create_list(:vendor, 1).first
    MarketVendor.create(market_id: market.id, vendor_id: vendor.id)
    market_vendor = MarketVendor.new(market_id: market.id, vendor_id: vendor.id)
    expect(market_vendor.save(market_id: market.id, vendor_id: vendor.id)).to be false
  end
end