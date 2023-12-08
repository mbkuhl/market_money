class AtmFacade

  def initialize(market)
    @market = market
  end

  def nearest_atms
    lat = @market.lat
    lon = @market.lon
    service = AtmService.new(lat, lon)
    data = service.get_atm_list
    atm_maker(data)
  end

  def atm_maker(data)
    data[:results].map do |atm_data|
      require 'pry'; binding.pry
      Atm.new(atm_data)
    end
  end

end