class AtmService

  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  def key
    Rails.application.credentials.tomtom[:key]
  end

  def conn
    require 'pry'; binding.pry
    Faraday.new(url: "https://api.tomtom.com/search/2/categorySearch/ATM.json?lat=#{@lat}&lon=#{@lon}&categorySet=7397&view=Unified&relatedPois=child&key=#{key}")
  end

  def get_atm_list
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
    require 'pry'; binding.pry
  end

end