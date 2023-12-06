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

  it "create vendor" do
    new_vendor = {
      "name": "Buzzy Bees",
      "description": "local honey and wax products",
      "contact_name": "Berly Couwer",
      "contact_phone": "8389928383",
      "credit_accepted": false
    }

    post "/api/v0/vendors", params: new_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(201)


    vendor = JSON.parse(response.body, symbolize_names: true)[:data]

    vendor_attributes = vendor[:attributes]

    expect(vendor_attributes).to have_key(:name)
    expect(vendor_attributes[:name]).to eq("Buzzy Bees")

    expect(vendor_attributes).to have_key(:description)
    expect(vendor_attributes[:description]).to eq("local honey and wax products")

    expect(vendor_attributes).to have_key(:contact_name)
    expect(vendor_attributes[:contact_name]).to eq("Berly Couwer")

    expect(vendor_attributes).to have_key(:contact_phone)
    expect(vendor_attributes[:contact_phone]).to eq("8389928383")

    expect(vendor_attributes).to have_key(:credit_accepted)
    expect(vendor_attributes[:credit_accepted]).to be(false)
  end

  it "create vendor" do
    new_vendor = {
      "name": "Buzzy Bees",
      "description": "local honey and wax products",
      "credit_accepted": false
    }

    post "/api/v0/vendors", params: new_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: Contact name can't be blank, Contact phone can't be blank")
  end
end