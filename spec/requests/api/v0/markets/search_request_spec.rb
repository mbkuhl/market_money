require 'rails_helper'

describe "Search API" do
  it "can search market based on parameters" do
    market = Market.create!(name: "Nob Hill Growers' Market", street: "Lead & Morningside SE", city: "Albuquerque", county: "Bernalillo", state: "New Mexico", lat: "35.077529", lon: "-106.600449")
    create_list(:market, 20)
    get "/api/v0/markets/search?city=albuquerque&state=new Mexico&name=Nob hill"
    expect(response).to be_successful

    market = JSON.parse(response.body, symbolize_names: true)[:data].first

    expect(market[:id]).to be_a(String)

    attributes = market[:attributes]

    attributes = market[:attributes]
    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to eq("Nob Hill Growers' Market")

    expect(attributes).to have_key(:street)
    expect(attributes[:street]).to eq("Lead & Morningside SE")

    expect(attributes).to have_key(:city)
    expect(attributes[:city]).to eq("Albuquerque")

    expect(attributes).to have_key(:county)
    expect(attributes[:county]).to eq("Bernalillo")

    expect(attributes).to have_key(:state)
    expect(attributes[:state]).to eq("New Mexico")

    expect(attributes).to have_key(:zip)
    expect(attributes[:zip]).to be nil

    expect(attributes).to have_key(:lat)
    expect(attributes[:lat]).to eq("35.077529")

    expect(attributes).to have_key(:lon)
    expect(attributes[:lon]).to eq("-106.600449")
    
    expect(attributes).to have_key(:vendor_count)
    expect(attributes[:vendor_count]).to be_a(Integer)
  end

  it "error invalid params (can't search city without state)" do
    create_list(:vendor, 20)
    market = Market.create!(name: "Nob Hill Growers' Market", street: "Lead & Morningside SE", city: "Albuquerque", county: "Bernalillo", state: "New Mexico", lat: "35.077529", lon: "-106.600449")
    create_list(:market, 20)
    create_list(:market_vendor, 10)
    get "/api/v0/markets/search?city=albuquerque&name=Nob hill"
    expect(response).to_not be_successful

    expect(response.status).to eq(422)

    error = JSON.parse(response.body, symbolize_names: true)[:errors]
    expect(error.first[:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")

    get "/api/v0/markets/search?city=albuquerque"
    expect(response).to_not be_successful

    expect(response.status).to eq(422)

    error = JSON.parse(response.body, symbolize_names: true)[:errors]
    expect(error.first[:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")

  end
end