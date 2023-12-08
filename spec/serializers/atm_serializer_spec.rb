require 'rails_helper'

describe "ATMt Serializer" do
  it "can make ATM hashes" do
    atm_data = {:type=>"POI",
      :id=>"zCkCLyNT3JUF8Kf5TsnodA",
      :score=>2.8319703478,
      :dist=>169.766658,
      :info=>"search:ta:840359000810929-US",
      :poi=>{:name=>"ATM", :categorySet=>[{:id=>7397}], :categories=>["cash dispenser"], :classifications=>[{:code=>"CASH_DISPENSER", :names=>[{:nameLocale=>"en-US", :name=>"cash dispenser"}]}]},
      :address=>
       {:streetNumber=>"3902",
        :streetName=>"Central Avenue Southeast",
        :municipalitySubdivision=>"Nob Hill",
        :municipality=>"Albuquerque",
        :countrySecondarySubdivision=>"Bernalillo",
        :countrySubdivision=>"NM",
        :countrySubdivisionName=>"New Mexico",
        :countrySubdivisionCode=>"NM",
        :postalCode=>"87108",
        :extendedPostalCode=>"87108-1017",
        :countryCode=>"US",
        :country=>"United States",
        :countryCodeISO3=>"USA",
        :freeformAddress=>"3902 Central Avenue Southeast, Albuquerque, NM 87108",
        :localName=>"Albuquerque"},
      :position=>{:lat=>35.079044, :lon=>-106.60068},
      :viewport=>{:topLeftPoint=>{:lat=>35.07994, :lon=>-106.60178}, :btmRightPoint=>{:lat=>35.07814, :lon=>-106.59958}},
      :entryPoints=>[{:type=>"main", :position=>{:lat=>35.07929, :lon=>-106.60064}}]}

      atm = Atm.new(atm_data)
    atms = AtmSerializer.new([atm]).to_hash[:data]

    expect(atms.count).to eq(1)
    atm = atms.first
    expect(atm).to have_key(:id)
    expect(atm[:id]).to be nil

    attributes = atm[:attributes]
    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:address)
    expect(attributes[:address]).to be_a(String)

    expect(attributes).to have_key(:lat)
    expect(attributes[:lat]).to be_a(Float)

    expect(attributes).to have_key(:lon)
    expect(attributes[:lon]).to be_a(Float)

    expect(attributes).to have_key(:distance)
    expect(attributes[:distance]).to be_a(Float)

    expect(attributes).to have_key(:lon)
    expect(attributes[:lon]).to be_a(Float)
  end
end