# == Schema Information
#
# Table name: rides
#
#  id                          :integer          not null, primary key
#  commute_distance_in_miles   :string
#  commute_duration_in_minutes :string
#  distance_in_miles           :string
#  duration_in_minutes         :string
#  earnings                    :integer
#  score                       :float
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  driver_id                   :integer
#
# Indexes
#
#  index_rides_by_score  (score)
#
class Ride < ApplicationRecord
  has_one :start_address, as: :addressable, class_name: 'Address',  dependent: :destroy 
  has_one :destination_address, as: :addressable, dependent: :destroy
  belongs_to :driver, optional: true

  @headers = {
    accept: 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
    Authorization: Rails.application.credentials.dig(:open_route_service, :api_key),
    'Content-Type': 'application/json; charset=utf-8'
  }

  @google_maps_api_key = Rails.application.credentials.dig(:google, :maps_api_key)

  def self.calculate_distance_and_duration(home_address, start_address)
    gmaps_url = "https://maps.googleapis.com/maps/api/distancematrix/json?"
    params = {destinations: start_address, origins: home_address, units: "imperial", key: Rails.application.credentials.dig(:google, :maps_api_key)}

    connection = Faraday.new(url: "#{gmaps_url}#{params}", params: params)
    response = connection.get()

    distance_in_miles = JSON.parse(response.body).fetch("rows").first.fetch("elements").first.fetch("distance").fetch("text").gsub(/\s+\w+/, "")
    duration_in_minutes = JSON.parse(response.body).fetch("rows").first.fetch("elements").first.fetch("duration").fetch("text").gsub(/\D/, "") 

    return { distance_in_miles: distance_in_miles, duration_in_minutes: duration_in_minutes }
  end
  #
  # calulate_earnings formula: $12 + $1.50 per mile beyond 5 miles + (ride duration) * $0.70 per minute beyond 15 minutes
  #
  def self.calculate_earnings(distance_in_miles, duration_in_minutes)
    earnings_by_distance_in_cents = 1200 # start rate per ride
    earnings_by_time_in_cents = 0
    mile_count = 0
    total_earnings_in_cents = 0

    (1..distance_in_miles.to_i).each do |mile|
      mile_count += 1
      if mile_count > 5 
        earnings_by_distance_in_cents += 150 
      end
    end

    earnings_by_time_in_cents = ((duration_in_minutes.to_i - 15 ) * 70)
    total_earnings_in_cents = earnings_by_distance_in_cents + earnings_by_time_in_cents
    return  '%.2f' % Rational(total_earnings_in_cents.to_i, 100.0)
  end

  def self.calculate_score(commute_duration_in_minutes, ride_duration_in_minutes, ride_distance_in_miles)
    ride_earnings = calculate_earnings(ride_distance_in_miles, ride_duration_in_minutes)
    return ride_earnings.to_f / (commute_duration_in_minutes.to_i + ride_duration_in_minutes.to_i)
  end
end
