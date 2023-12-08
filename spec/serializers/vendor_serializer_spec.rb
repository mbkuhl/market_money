require 'rails_helper'

describe "Vendor Serializer" do
  it "can make vendor hashes" do
    create_list(:vendor, 3)
    vendors = VendorSerializer.new(Vendor.all).to_hash[:data]

    expect(vendors.count).to eq(3)
    vendor = vendors.first
    expect(vendor).to have_key(:id)
    expect(vendor[:id]).to be_an(String)

    attributes = vendor[:attributes]
    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:description)
    expect(attributes[:description]).to be_a(String)

    expect(attributes).to have_key(:contact_name)
    expect(attributes[:contact_name]).to be_a(String)

    expect(attributes).to have_key(:contact_phone)
    expect(attributes[:contact_phone]).to be_a(String)

    expect(attributes).to have_key(:credit_accepted)
    expect(attributes[:credit_accepted]).to be_in([true, false])
  end
end