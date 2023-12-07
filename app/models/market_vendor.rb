class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor
  validate :uniqueness_of_relationship

  def uniqueness_of_relationship
    if MarketVendor.where("market_id =#{market_id} and vendor_id =#{vendor_id}").count > 0
      errors.add(:details, "Validation failed: Market vendor asociation between market with market_id=#{market_id} and vendor_id=#{vendor_id} already exists")
    end
  end
    
    
end