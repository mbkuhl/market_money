require 'rails_helper'

describe "Vendor API" do
  it "sends a list of vendors" do
    create_list(:vendor, 20)
    create_list(:market, 20)
    create_list(:market_vendor, 50)
    get "/api/v0/markets/#{Market.all.first.id}/vendors"

    expect(response).to be_successful

    vendors = JSON.parse(response.body, symbolize_names: true)[:data]

    # expect(vendors.count).to eq(3)

    vendors.each do |vendor|
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
  end
end