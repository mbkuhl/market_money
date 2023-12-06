class Api::V0::VendorsController < ApplicationController

  def show
    begin
      render json: VendorSerializer.new(Vendor.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => exception
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
    end
  end

  def create
    begin
      vendor = Vendor.create!(strong_params)
      render json: VendorSerializer.new(vendor), status: :created
    rescue ActiveRecord::RecordInvalid => exception
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
      .validation_fail, status: 400
    end
  end

  def destroy
    vendor = Vendor.destroy(params[:id])
  end

  private
  def strong_params
    params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

end
