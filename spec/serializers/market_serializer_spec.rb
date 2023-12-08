require 'rails_helper'

describe "Market Serializer" do
  it "can make market hashes" do
    create_list(:market, 3)
    markets = MarketSerializer.new(Market.all).to_hash[:data]

    expect(markets.count).to eq(3)
    market = markets.first
    expect(market).to have_key(:id)
    expect(market[:id]).to be_an(String)

    attributes = market[:attributes]
    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:street)
    expect(attributes[:street]).to be_a(String)

    expect(attributes).to have_key(:city)
    expect(attributes[:city]).to be_a(String)

    expect(attributes).to have_key(:county)
    expect(attributes[:county]).to be_a(String)

    expect(attributes).to have_key(:state)
    expect(attributes[:state]).to be_an(String)
    expect(attributes[:state].length).to eq(2)

    expect(attributes).to have_key(:zip)
    expect(attributes[:zip]).to be_a(String)

    expect(attributes).to have_key(:lat)
    expect(attributes[:lat]).to be_a(String)

    expect(attributes).to have_key(:lon)
    expect(attributes[:lon]).to be_a(String)
  end

  it "can give cash only" do
    create_list(:market, 2)
    cash_market = Market.all.first
    mixed_market = Market.all.last
    v1 = Vendor.create!(name: "Buzzy Bees", description: "local honey and wax products", contact_name: "Berly Couwer", contact_phone: "8389928383", credit_accepted: false )
    v2 = Vendor.create!(name: "Buzzy Bees", description: "local honey and wax products", contact_name: "Berly Couwer", contact_phone: "8389928383", credit_accepted: false )
    v3 = Vendor.create!(name: "Buzzy Bees", description: "local honey and wax products", contact_name: "Berly Couwer", contact_phone: "8389928383", credit_accepted: true )
    v4 = Vendor.create!(name: "Buzzy Bees", description: "local honey and wax products", contact_name: "Berly Couwer", contact_phone: "8389928383", credit_accepted: false )
    MarketVendor.create(market_id: cash_market.id, vendor_id: v1.id)
    MarketVendor.create(market_id: cash_market.id, vendor_id: v2.id)
    MarketVendor.create(market_id: mixed_market.id, vendor_id: v3.id)
    MarketVendor.create(market_id: mixed_market.id, vendor_id: v4.id)
    
    markets = MarketSerializer.new(Market.all).to_hash[:data]

    expect(markets.first[:attributes][:cash_only]).to be true
    expect(markets.last[:attributes][:cash_only]).to be false
  end
end