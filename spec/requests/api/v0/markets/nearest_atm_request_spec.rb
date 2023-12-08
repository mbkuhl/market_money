require 'rails_helper'

describe "Nearest ATM to market API", :vcr do
  it "can search for nearest ATMS to market" do
    market = Market.create!(name: "Nob Hill Growers' Market", street: "Lead & Morningside SE", city: "Albuquerque", county: "Bernalillo", state: "New Mexico", lat: "35.077529", lon: "-106.600449")
    get "/api/v0/markets/#{market.id}/nearest_atms"

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(data.count).to eq(10)
    atm = data.first
    expect(atm[:id]).to be nil

    attributes = atm[:attributes]
    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to eq("ATM")

    expect(attributes).to have_key(:address)
    expect(attributes[:address]).to eq("3902 Central Avenue Southeast, Albuquerque, NM 87108")

    expect(attributes).to have_key(:lat)
    expect(attributes[:lat]).to eq(35.079044)

    expect(attributes).to have_key(:lon)
    expect(attributes[:lon]).to eq(-106.60068)
    
    expect(attributes).to have_key(:distance)
    expect(attributes[:distance]).to be_a(Float)
  end

  it "will gracefully handle if a book id doesn't exist" do
    get "/api/v0/markets/1/nearest_atms"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=1")
  end
end
