class Api::V0::Markets::VendorsController < ApplicationController
  def index
    market = Market.find(params[:market_id])
    render json: VendorSerializer.new(market.vendors.all)
  end

  def show
    vendor = Vendor.find(params[:vendor_id])
    render json: VendorSerializer.new(Vendor.find(params[:vendor_id]))
  end
end