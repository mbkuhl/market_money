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

  it "will gracefully handle if a vendor id doesn't exist" do
    get "/api/v0/vendors/1"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=1")
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

  it "create vendor sad path" do
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

  it "delete vendor" do
    create_list(:vendor, 1)

    expect(Vendor.all.count).to eq(1)
    vendor = Vendor.all.first
    expect(vendor.name).to be_a(String)
    delete "/api/v0/vendors/#{vendor.id}", headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect(response.body).to eq("")
    expect(Vendor.all.count).to eq(0)
    vendor = Vendor.all.first
    expect(vendor).to be nil
  end

  it "update vendor" do
    new_vendor = {
      "name": "Buzzy Bees",
      "description": "local honey and wax products",
      "contact_name": "Berly Couwer",
      "contact_phone": "8389928383",
      "credit_accepted": true
    }
    post "/api/v0/vendors", params: new_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    vendor_id = Vendor.all.first.id
    vendor = Vendor.all.first
    expect(vendor.contact_name).to eq("Berly Couwer")
    expect(vendor.credit_accepted).to be true
    update_vendor = 
      {
        "contact_name": "Kimberly Couwer",
        "credit_accepted": false
    }
    

    patch "/api/v0/vendors/#{vendor_id}", params: update_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)[:data]
    attributes = data[:attributes]
    expect(data[:id]).to eq(vendor_id.to_s)
    expect(attributes[:contact_name]).to eq("Kimberly Couwer")
    expect(attributes[:credit_accepted]).to be false
  end

  it "will gracefully handle if a vendor id doesn't exist" do
    new_vendor = {
      "name": "Buzzy Bees",
      "description": "local honey and wax products",
      "contact_name": "Berly Couwer",
      "contact_phone": "8389928383",
      "credit_accepted": true
    }
    post "/api/v0/vendors", params: new_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    vendor_id = Vendor.all.first.id
    vendor = Vendor.all.first
    expect(vendor.contact_name).to eq("Berly Couwer")
    expect(vendor.credit_accepted).to be true
    update_vendor = 
      {
        "contact_name": "Kimberly Couwer",
        "credit_accepted": false
    }
    

    patch "/api/v0/vendors/1", params: update_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=1")
  end

  it "error handling for bad update params" do
    new_vendor = {
      "name": "Buzzy Bees",
      "description": "local honey and wax products",
      "contact_name": "Berly Couwer",
      "contact_phone": "8389928383",
      "credit_accepted": true
    }
    post "/api/v0/vendors", params: new_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    vendor_id = Vendor.all.first.id
    vendor = Vendor.all.first
    expect(vendor.contact_name).to eq("Berly Couwer")
    expect(vendor.credit_accepted).to be true
    update_vendor = 
      {
        "contact_name": "",
        "credit_accepted": false
    }
    

    patch "/api/v0/vendors/#{vendor_id}", params: update_vendor.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
   
    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: Contact name can't be blank")
  end
end