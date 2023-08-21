class Api::V1::RidesController < ApplicationController
  
  def index
    @driver = Driver.first 
    @rides_desc = @driver.rides.order(score: :desc).paginate(page: params[:page])

    if @rides_desc.blank?
      render json: { status: 400, body: 'No rides available, please try again shortly' }
    else 
      render json: { status: 200, body: @rides_desc }
    end
  end
end