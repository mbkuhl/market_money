class Api::V0::MarketVendorsController < ApplicationController

  def create
    begin
      vendor = MarketVendor.create!(strong_params)
      render json: { "message": "Successfully added vendor to market"}, status: :created
    rescue ActiveRecord::RecordInvalid => exception
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
      .validation_fail, status: 400
    end
  end

  def destroy

  end

  def strong_params
    params.permit(:market_id, :vendor_id)
  end
end