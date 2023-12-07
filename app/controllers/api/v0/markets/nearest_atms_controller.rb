class Api::V0::Markets::NearestAtmsController < ApplicationController
  def index
    begin
      render json: NearestAtmsSerializer.new(Market.nearest_atms(params))
    rescue ActiveRecord::RecordNotFound => exception
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
    end
  end


end