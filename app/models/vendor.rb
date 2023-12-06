class Vendor < ApplicationRecord
  has_many :market_vendors
  has_many :markets, through: :market_vendors

  # before_save { |market| market.vendor_count = vendors.count }

  # private
  # def count_of_markets
  #   markets.count
  # end
end