class Api::V0::MarketVendorsController < ApplicationController

  def create
    begin
      vendor = MarketVendor.create!(strong_params)
      render json: { "message": "Successfully added vendor to market"}, status: :created
    rescue ActiveRecord::RecordInvalid => exception
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, ErrorMessage.market_vendor_create_status(exception)))
      .validation_fail, status: ErrorMessage.market_vendor_create_status(exception)
    end
  end

  def destroy
    begin
      MarketVendor.destroy(MarketVendor.find_by(market_id: params[:market_id], vendor_id: params[:vendor_id])&.id)
    rescue ActiveRecord::RecordNotFound => exception
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .no_market_vendor(params[:market_id], params[:vendor_id]), status: 404
    end
  end

  def strong_params
    params.permit(:market_id, :vendor_id)
  end
end