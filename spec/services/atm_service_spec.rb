require 'rails_helper'

describe AtmService do
  it "#details_api_call(movie_id)", :vcr do
    atm = AtmService.new(35.07904, -106.60068)

    list = atm.get_atm_list
    expect(list).to be_a(Hash)
  end
end
