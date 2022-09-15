# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

    Role.find_or_create_by!(id: 1, name: 'Admin')
    Role.find_or_create_by!(id: 2, name: 'Customer')

    unless User.find_by(email: 'admin@gmail.com')
        User.create!(name: 'Admin', email: 'admin@gmail.com', phone: 9876543210, role_id: 1, password: '123456789', password_confirmation: '123456789')
    end