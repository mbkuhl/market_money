require 'rails_helper'

describe "Vendor API" do
  it "create vendor" do
    create_list(:market, 1)
    create_list(:vendor, 1)

    market = Market.all.first
    vendor = Vendor.all.first

    new_market_vendor = {
      "market_id": market.id, 
      "vendor_id": vendor.id 
    }

    post "/api/v0/market_vendors", params: new_market_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(201)


    success = JSON.parse(response.body, symbolize_names: true)[:message]

    expect(success).to eq("Successfully added vendor to market")

    market_vendor = MarketVendor.all.first
    expect(market_vendor.market_id).to eq(market.id)
    expect(market_vendor.vendor_id).to eq(vendor.id)
  end
end