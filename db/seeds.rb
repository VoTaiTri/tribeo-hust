puts "Create admin"
User.create!(name:  "VoTaiTri", email: "admin@crb.com", password: 123456, password_confirmation: 123456, role: "admin")

puts "Create 5 user"
5.times do
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 123456, password_confirmation: 123456)
end