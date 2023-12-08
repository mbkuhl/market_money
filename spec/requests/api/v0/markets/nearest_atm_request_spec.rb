require 'rails_helper'

describe "Nearest ATM to market API", :vcr do
  it "can search for nearest ATMS to market" do
    market = Market.create!(name: "Nob Hill Growers' Market", street: "Lead & Morningside SE", city: "Albuquerque", county: "Bernalillo", state: "New Mexico", lat: "35.077529", lon: "-106.600449")
    get "/api/v0/markets/#{market.id}/nearest_atms"

    expect(response).to be_successful

    atm = JSON.parse(response.body, symbolize_names: true)[:data].first

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
  end
end
