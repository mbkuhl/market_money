require 'rails_helper'

describe "Markets API" do
  it "sends a list of markets" do
    create_list(:market, 3)

    get '/api/v0/markets'
    
    expect(response).to be_successful

    markets = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(markets.count).to eq(3)

    markets.each do |market|
      expect(market).to have_key(:id)
      expect(market[:id]).to be_an(Integer)

      expect(market).to have_key(:title)
      expect(market[:title]).to be_a(String)

      expect(market).to have_key(:author)
      expect(market[:author]).to be_a(String)

      expect(market).to have_key(:genre)
      expect(market[:genre]).to be_a(String)

      expect(market).to have_key(:summary)
      expect(market[:summary]).to be_a(String)

      expect(market).to have_key(:number_sold)
      expect(market[:number_sold]).to be_an(Integer)
    end
  end
end