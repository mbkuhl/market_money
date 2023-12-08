require "rails_helper"

RSpec.describe Market, type: :model do
  
  describe "relationships" do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  it "::search" do
    market = Market.create!(name: "Nob Hill Growers' Market", street: "Lead & Morningside SE", city: "Albuquerque", county: "Bernalillo", state: "New Mexico", lat: "35.077529", lon: "-106.600449")
    create_list(:market, 20)
    expect(Market.search(city: "alb", state:"new mexico", name:"nob")).to eq([market])
  end
end