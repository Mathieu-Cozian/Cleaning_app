puts "destroying all apartment"
Apartment.destroy_all
puts "Destroying all Cleaners"
Cleaner.destroy_all
puts "destroying all clients"
Client.destroy_all
puts "Destroying all Users"
User.destroy_all

puts "Creating mathieu user"
User.create!(email: "mathieu@mail.com", password: "password", first_name: "Mathieu", last_name: "Cozian")

puts "Creating clients"
20.times do
  Client.create!(user: User.create!(email: Faker::Internet.email, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name))
end
puts "Done creating clients"