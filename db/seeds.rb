# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Users
User.create!(full_name:  "Admin User",
             email: "admin@example.com",
             mobile_number: "123123123",
             password:              "Password1",
             password_confirmation: "Password1",
             admin: true)

User.create!(full_name:  "Example User",
             email: "user@example.com",
             mobile_number: "321321321",
             password:              "Password1",
             password_confirmation: "Password1")

# Movies
3.times do
    title = Faker::Movie.title
    synopsis = Faker::Lorem.sentence(word_count: 15)
    Movie.create!(title: title, synopsis: synopsis)
end

# Cinemas
3.times do |n|
    name = "#{Faker::Company.name} Theater"
    location = Faker::Address.city
    Cinema.create!(name: name, location: location, seats: 10-n)
end

# Showing
Showing.create!(timeslot: 600,
                cinema_id: 1,
                movie_id: 1)
