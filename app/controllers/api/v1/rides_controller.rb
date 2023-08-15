class Api::V1::RidesController < ApplicationController
  def index
    @rides = Ride.all

    render json: @rides
  end
end