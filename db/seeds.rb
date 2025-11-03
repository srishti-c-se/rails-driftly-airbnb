# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# vehicles
# db/seeds.rb

# First, clear existing data to avoid duplicates
puts "Clearing existing data..."
Review.destroy_all
Booking.destroy_all
Vehicle.destroy_all
User.destroy_all

puts "Creating users..."
user1 = User.find_or_create_by!(email: "john.doe@example.com") do |user| user.password = "password123";user.first_name = "John";user.last_name = "Doe";user.phone = "12345678901"; user.address = "123 Main St, Los Angeles, CA";  user.latitude = 34.0522 ;user.longitude = -118.2437 ; user.admin = false end

user2 = User.find_or_create_by!(email: "jane.smith@example.com") do |user|  user.password = "password321";user.first_name = "Jane";user.last_name = "Smith" ; user.phone = "9876543210";user.address = "456 Park Ave, New York, NY"; user.latitude = 40.7128 ;user.longitude = -74.0060 ; user.admin = true end

user3 = User.find_or_create_by!(email: "tom.smith@example.com") do |user|   user.password = "password123d";user.first_name = "Tom"; user.last_name = "Smith"; user.phone = "9876543210";user.address = "456 Park Ave, New York, NY"; user.latitude = 40.7128 ;user.longitude = -74.0060 ; user.admin = true end

user4 = User.find_or_create_by!(email: "mike.tracer@example.com") do |user|  user.password = "password454"; user.first_name = "Mike";user.last_name = "Tracer"; user.phone = "8998765674";user.address = "654 Main St, Reunion, CA"; user.latitude = 40.7128;user.longitude = -74.0060; user.admin = true end

# puts "Creating users"
# # Example seed data
# puts 'Creating vehicles...'
# tour_d_argent = Vehicle.new("title: "brand,model,year")
# tour_d_argent.save!

# chez_gladines = Vehicle.new(name: "Chez Gladines")
# chez_gladines.save!

puts "Creating vehicles..."
vehicle1 = Vehicle.new(user: user1, title: "Toyota Corolla", brand: "Toyota", model: "Corolla", year: 2020, seats: 5, transmission: 1, fuel_type: 0, price_per_day: 65.50,  address: "123 Main St, Los Angeles, CA", latitude: 34.0522, longitude: -118.2437, active: true, description: "A comfortable and reliable sedan with great mileage."
)
vehicle1.save!

vehicle2 = Vehicle.new(user: user2, title: "Tesla Model 3", brand: "Tesla", model: "Model 3", year: 2023, seats: 5, transmission: 1, fuel_type: 2,  price_per_day: 120.00, address: "456 Park Ave, New York, NY", latitude: 40.7128, longitude: -74.0060, active: true, description: "Fully electric vehicle with autopilot and premium features."
)
vehicle2.save!

vehicle3 = Vehicle.new(user: user3, title: "Ford Mustang",  brand: "Ford", model: "Mustang",year: 2019, seats: 4, transmission: 0, fuel_type: 0, price_per_day: 95.00,  address: "456 Park Ave, New York, NY", latitude: 40.7128,longitude: -74.0060,  active: true, description: "Classic sports car with powerful performance and style."
)
vehicle3.save!

vehicle4 = Vehicle.new(user: user4, title: "Jeep Wrangler",  brand: "Jeep", model: "Wrangler",  year: 2021, seats: 5, transmission: 1, fuel_type: 1, price_per_day: 85.00, address: "654 Main St, Reunion, CA", latitude: 40.7128, longitude: -74.0060,  active: false,  description: "Off-road SUV perfect for adventure and rough terrain."
)
vehicle4.save!

puts "Creating bookings and reviews..."
Vehicle.all.each do |vehicle|
  user = User.where.not(id: vehicle.user.id).sample
  start_date = Faker::Date.forward(days: 5)
  end_date = start_date + rand(2..7).days

booking = Booking.create!(user: user, vehicle: vehicle, start_date: start_date, end_date: end_date, pickup_address: Faker::Address.street_address, dropoff_address: Faker::Address.street_address, total_price: vehicle.price_per_day * ((end_date - start_date).to_i),  status: [0, 1, 2].sample, payment_status: [0, 1].sample
  )

Review.create!(user: booking.user, vehicle: booking.vehicle, booking: booking, rating: rand(3..5), comment: Faker::Lorem.sentence(word_count: rand(10..20)))
end

puts "Created #{User.count} users, #{Vehicle.count} vehicles, #{Booking.count} bookings, #{Review.count} reviews."
