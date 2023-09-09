# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Driver.delete_all
puts "...deleteing old data"

addresses = JSON.parse(File.read(Rails.root + "db/random_us_addresses.json"))
ride_start_addresses = addresses.slice(0..121) # split total addresses 
ride_destination_addresses = addresses.slice(122..245)

driver = Driver.new
driver.build_home_address(
  addressable_id: driver.id,
  street_address: "151 Main Street",
  city: "Savannah",
  state: "GA",
  zip_code: "31408"
)

driver.save
rides = []
122.times do
  ride = driver.rides.create!(
    driver_id: driver.id,
  )
  rides << ride
end

ride_start_addresses.each_with_index do |start_address, index|
  start_address = rides[index].build_start_address(
    addressable_id: rides[index].id,
    street_address: start_address["address1"],
    city: start_address["city"],
    state: start_address["state"],
    zip_code: start_address["postalCode"]
  )
  puts "start address: => #{rides[index].start_address.to_json}"
end

ride_destination_addresses.each_with_index do |destination_address, index|
  destination_address = rides[index].build_destination_address(
    addressable_id: rides[index].id,
    street_address: destination_address["address1"],
    city: destination_address["city"],
    state: destination_address["state"],
    zip_code: destination_address["postalCode"]
  )
  puts "destination address: => #{rides[index].destination_address.to_json}"
end

rides.each do |ride|
  puts "calculating ride data..."
  ride_start_address = "#{ride.start_address.street_address.to_json} #{ride.start_address.city.to_json} #{ride.start_address.state.to_json} #{ride.start_address.zip_code.to_json}"
  ride_destination_address = "#{ride.destination_address.street_address.to_json} #{ride.destination_address.city.to_json} #{ride.destination_address.state.to_json} #{ride.destination_address.zip_code.to_json}"
  commute_start_address = "#{driver.home_address.street_address.to_json} #{driver.home_address.city.to_json} #{driver.home_address.state.to_json} #{driver.home_address.zip_code.to_json}"
  
  ride_response = Ride.calculate_distance_and_duration(ride_start_address, ride_destination_address)
  commute_response = Ride.calculate_distance_and_duration(commute_start_address, ride_start_address)
  earnings_response = Ride.calculate_earnings(ride_response[:distance_in_miles], ride_response[:distance_in_minutes])
  score_response = Ride.calculate_score(commute_response[:duration_in_minutes], ride_response[:duration_in_minutes], ride_response[:distance_in_miles])

  ride.update(
    distance_in_miles: ride_response[:distance_in_miles], 
    duration_in_minutes: ride_response[:duration_in_minutes], 
    commute_distance_in_miles: commute_response[:distance_in_miles], 
    commute_duration_in_minutes: commute_response[:duration_in_minutes], 
    earnings: earnings_response,score: score_response
  )
end
puts "<---------------Complete!---------------->"





  

