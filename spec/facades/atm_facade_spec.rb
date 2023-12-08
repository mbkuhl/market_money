require "rails_helper"

RSpec.describe AtmFacade do
  

  it "can make an array of ATM objects", :vcr do
    market = Market.create!(name: "Nob Hill Growers' Market", street: "Lead & Morningside SE", city: "Albuquerque", county: "Bernalillo", state: "New Mexico", lat: "35.077529", lon: "-106.600449")

    atm_facade = AtmFacade.new(market)
    expect(atm_facade).to be_a(AtmFacade)

    atms = atm_facade.nearest_atms

    expect(atms.count).to eq(10)
    expect(atms.first).to be_an(Atm)
  end
end

