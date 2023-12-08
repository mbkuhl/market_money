require "rails_helper"

RSpec.describe ErrorMessage do
  it "exists" do
    begin
      MarketVendor.find(1)
    rescue ActiveRecord::RecordNotFound => exception
      @error_message = ErrorMessage.new(exception.message, 404)
    end
    expect(@error_message.message).to eq("Couldn't find MarketVendor with 'id'=1")
    expect(@error_message.status_code).to eq(404)

  end

  it "::market_vendor_create_status" do
    market = create_list(:market, 1).first
    vendor = create_list(:vendor, 1).first
    MarketVendor.create(market_id: market.id, vendor_id: vendor.id)
    begin
      MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)
    rescue ActiveRecord::RecordInvalid => exception
      @exception = exception
    end
    expect(ErrorMessage.market_vendor_create_status(@exception)).to eq(422)


    begin
      MarketVendor.find(1)
    rescue ActiveRecord::RecordNotFound => exception
      @exception = exception
    end
    expect(ErrorMessage.market_vendor_create_status(@exception)).to eq(404)
  end
end