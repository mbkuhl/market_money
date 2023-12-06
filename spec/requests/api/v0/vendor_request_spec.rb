require 'rails_helper'

describe "Vendor API" do
  it "sends a list of vendors" do
    create_list(:vendor, 3)

    get '/api/v0/vendors'

    expect(response).to be_successful

    vendors = JSON.parse(response.body, symbolize_names: true)

    expect(vendors[:data].count).to eq(3)

    vendors.each do |vendor|
      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to be_an(Integer)

      expect(vendor).to have_key(:title)
      expect(vendor[:title]).to be_a(String)

      expect(vendor).to have_key(:author)
      expect(vendor[:author]).to be_a(String)

      expect(vendor).to have_key(:genre)
      expect(vendor[:genre]).to be_a(String)

      expect(vendor).to have_key(:summary)
      expect(vendor[:summary]).to be_a(String)

      expect(vendor).to have_key(:number_sold)
      expect(vendor[:number_sold]).to be_an(Integer)
    end
  end
end