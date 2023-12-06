class Api::V0::VendorsController < ApplicationController
  def show
    vendor = Vendor.find(params[:id])
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end


end
def show
  vendor = Vendor.find(params[:id])
  render json: VendorSerializer.new(Vendor.find(params[:id]))
end