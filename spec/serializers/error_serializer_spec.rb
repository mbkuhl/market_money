require 'rails_helper'

describe "Error Serializer" do
  it "#serialize_jason" do
    begin
      1/0
    rescue => exception
      @error = exception
    end
    error = ErrorMessage.new(@error.message, 456)
    error_hash = ErrorSerializer.new(error).serialize_json

    expect(error_hash.count).to eq(1)
    error = error_hash
    expect(error).to have_key(:errors)
    expect(error[:errors]).to be_an(Array)

    error = error[:errors].first
    expect(error).to have_key(:status)
    expect(error[:status]).to be_a(String)
    expect(error[:status].to_i == 0).to be false

    expect(error).to have_key(:title)
    expect(error[:title]).to be_a(String)
  end
  
  it "#validation_fail" do
    begin
      1/0
    rescue => exception
      @error = exception
    end
    error = ErrorMessage.new(@error.message, 456)
    error_hash = ErrorSerializer.new(error).validation_fail

    expect(error_hash.count).to eq(1)
    error = error_hash
    expect(error).to have_key(:errors)
    expect(error[:errors]).to be_an(Array)

    error = error[:errors].first

    expect(error).to have_key(:detail)
    expect(error[:detail]).to be_a(String)
  end

  it "#invalid_params" do
    begin
      1/0
    rescue => exception
      @error = exception
    end
    error = ErrorMessage.new(@error.message, 456)
    error_hash = ErrorSerializer.new(error).invalid_params

    expect(error_hash.count).to eq(1)
    error = error_hash
    expect(error).to have_key(:errors)
    expect(error[:errors]).to be_an(Array)

    error = error[:errors].first

    expect(error).to have_key(:detail)
    expect(error[:detail]).to be_a(String)
  end

  it "#no_market_vendor" do
    error = 1
    error_hash = ErrorSerializer.new(error).no_market_vendor(2, 4)

    expect(error_hash.count).to eq(1)
    error = error_hash
    expect(error).to have_key(:errors)
    expect(error[:errors]).to be_an(Array)

    error = error[:errors].first

    expect(error).to have_key(:detail)
    expect(error[:detail]).to be_a(String)
  end
end