require 'rails_helper'

describe "Nearest ATM to market API", :vcr do
  it "can search for nearest ATMS to market" do
    market = Market.create!(name: "Nob Hill Growers' Market", street: "Lead & Morningside SE", city: "Albuquerque", county: "Bernalillo", state: "New Mexico", lat: "35.077529", lon: "-106.600449")
    get "/api/v0/markets/#{market.id}/nearest_atms"

    require 'pry'; binding.pry
    expect(response).to be_successful

    atm = JSON.parse(response.body, symbolize_names: true)[:data].first
    
  end
end
