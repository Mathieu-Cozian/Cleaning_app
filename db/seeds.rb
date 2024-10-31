puts "destroying all apartment"
Apartment.destroy_all
puts "Destroying all Cleaners"
Cleaner.destroy_all
puts "destroying all clients"
Client.destroy_all
puts "Destroying all Users"
User.destroy_all

puts "Creating mathieu user"
mathieu_user = User.create!(email: "mathieu@mail.com", password: "password", first_name: "Mathieu", last_name: "Cozian", is_admin: true)
Admin.create!(user: mathieu_user)

puts "Creating cleaners"

cleaner_statuses = {
    pending: 0,
    active: 1,
    inactive: 2,
    terminated: 3,
  }
30.times do
  user = User.create!(
    email: Faker::Internet.unique.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    is_cleaner: true,
    password: "password" # Adjust this as necessary for your app
  )

  # Associate each user with a Cleaner record
  Cleaner.create!(
    user: user,
    address: Faker::Address.full_address,
    status: cleaner_statuses.values.sample
  )
end
puts "Creating clients"
20.times do
  user = User.create!(email: Faker::Internet.email, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, is_client: true)
  Client.create!(user: user)
end

puts "Done creating clients"