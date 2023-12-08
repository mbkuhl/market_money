require 'rails_helper'

describe "Vendor API" do
  it "sends a list of vendors" do
    create_list(:vendor, 100)
    create_list(:market, 5)
    create_list(:market_vendor, 20)
    get "/api/v0/markets/#{Market.all.first.id}/vendors"

    expect(response).to be_successful

    vendor = JSON.parse(response.body, symbolize_names: true)[:data].first

    expect(vendor[:id]).to be_a(String)

    vendor_attributes = vendor[:attributes]

    expect(vendor_attributes).to have_key(:name)
    expect(vendor_attributes[:name]).to be_a(String)

    expect(vendor_attributes).to have_key(:description)
    expect(vendor_attributes[:description]).to be_a(String)

    expect(vendor_attributes).to have_key(:contact_name)
    expect(vendor_attributes[:contact_name]).to be_a(String)

    expect(vendor_attributes).to have_key(:contact_phone)
    expect(vendor_attributes[:contact_phone]).to be_a(String)

    expect(vendor_attributes).to have_key(:credit_accepted)
    expect(vendor_attributes[:credit_accepted]).to be_in([true, false])
  
  end

  it "will gracefully handle if a market id doesn't exist" do
    get "/api/v0/markets/1/vendors"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=1")
  end
end