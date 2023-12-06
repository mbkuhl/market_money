require 'rails_helper'

describe "Vendor API" do
  it "find vendor by id" do
    create_list(:vendor, 10)

    vendor_in = Vendor.all.first
    get "/api/v0/vendors/#{vendor_in.id}"

    expect(response).to be_successful

    vendor = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(vendor[:id].to_i).to eq(vendor_in.id)

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
    expect(vendor_attributes[:credit_accepted]).to be(vendor_in.credit_accepted)
  end
end