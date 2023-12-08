class AtmFacade

  def initialize(market)
    @market = market
  end

  def nearest_atms
    lat = @market.lat
    lon = @market.lon
    service = AtmService.new(lat, lon)
    data = service.get_atm_list
    require 'pry'; binding.pry
    atm_maker(data)
  end

  def atm_maker(data)

  end

end