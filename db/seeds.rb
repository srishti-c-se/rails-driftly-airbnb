# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!(
  email: "seb@mail.com",
  password: "123456",
  password_confirmation: "123456",
  first_name: "Sebastian",
  last_name: "Smith",
  address: "123 Main Street, Cityville",
  phone: "5551234"
)

User.create!(
  email: "boris@mail.com",
  password: "567890",
  password_confirmation: "567890",
  first_name: "Boris",
  last_name: "Johnson",
  address: "456 Elm Street, Townsville",
  phone: "5555678"
)
