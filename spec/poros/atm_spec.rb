require "rails_helper"

RSpec.describe Atm, type: :model do
  

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

    expect(atm).to be_an(Atm)
    expect(atm.id).to be nil
    expect(atm.name).to eq("ATM")
    expect(atm.address).to eq("3902 Central Avenue Southeast, Albuquerque, NM 87108")
    expect(atm.lat).to eq(35.079044)
    expect(atm.lon).to eq(-106.60068)
    expect(atm.distance).to eq(0.10521432030427412)
  end
end