# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

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