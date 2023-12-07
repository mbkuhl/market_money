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

  it "error market or vendor doesn't exist" do
    create_list(:market, 1)
    create_list(:vendor, 1)

    market = Market.all.first
    vendor = Vendor.all.first

    new_market_vendor = {
      "market_id": 1, 
      "vendor_id": vendor.id 
    }

    post "/api/v0/market_vendors", params: new_market_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(404)


    error = JSON.parse(response.body, symbolize_names: true)[:errors]
    expect(error.first[:detail]).to eq("Validation failed: Market must exist")
  end

  it "error create duplicate vendor" do
    create_list(:market, 1)
    create_list(:vendor, 1)

    market = Market.all.first
    vendor = Vendor.all.first

    new_market_vendor = {
      "market_id": market.id, 
      "vendor_id": vendor.id 
    }

    post "/api/v0/market_vendors", params: new_market_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    post "/api/v0/market_vendors", params: new_market_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(422)


    error = JSON.parse(response.body, symbolize_names: true)[:errors]
    expect(error.first[:detail]).to eq("Validation failed: Market vendor asociation between market with market_id=#{market.id} and vendor_id=#{vendor.id} already exists")

    market_vendor = MarketVendor.all.first
    expect(market_vendor.market_id).to eq(market.id)
    expect(market_vendor.vendor_id).to eq(vendor.id)
  end

  it "delete vendor" do
    create_list(:market, 1)
    create_list(:vendor, 1)

    market = Market.all.first
    vendor = Vendor.all.first

    new_market_vendor = {
      "market_id": market.id, 
      "vendor_id": vendor.id 
    }

    post "/api/v0/market_vendors", params: new_market_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(market_vendor = MarketVendor.all.count).to eq(1)
    
    delete "/api/v0/market_vendors", params: new_market_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    
    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(response.body).to eq("")
    expect(market_vendor = MarketVendor.all.count).to eq(0)
  end

  it "delete vendor NOT FOUND" do
    create_list(:market, 1)
    create_list(:vendor, 1)

    market = Market.all.first
    vendor = Vendor.all.first

    new_market_vendor = {
      "market_id": market.id, 
      "vendor_id": vendor.id 
    }

    post "/api/v0/market_vendors", params: new_market_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(market_vendor = MarketVendor.all.count).to eq(1)
    nonexistent_market_vendor = {
      "market_id": 1, 
      "vendor_id": vendor.id 
    }
    delete "/api/v0/market_vendors", params: nonexistent_market_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    
    error = JSON.parse(response.body, symbolize_names: true)[:errors]

    expect(error.first[:detail]).to eq("No MarketVendor with market_id=1 AND vendor_id=#{vendor.id} exists")
    
    market_vendor = MarketVendor.all.first
    expect(market_vendor.market_id).to eq(market.id)
    expect(market_vendor.vendor_id).to eq(vendor.id)
    expect(market_vendor = MarketVendor.all.count).to eq(1)
  end
end