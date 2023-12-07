class Market < ApplicationRecord
  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  def self.search(params)
    Market.where("markets.city ilike '%#{params[:city]}%' and markets.state ilike '%#{params[:state]}%' and markets.name ilike '%#{params[:name]}%'")
  end

  def self.nearest_atms(params)

  end
end