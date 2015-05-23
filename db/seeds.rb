puts "Create admin"
User.create!(name:  "VoTaiTri", email: "admin@crb.com", password: 123456, password_confirmation: 123456, role: "admin")

puts "Create 15 user"
15.times do
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 123456, password_confirmation: 123456)
end

puts "Create 5 subject"
Subject.create!(name: "Co so tri thuc", tc: 3, lt: 45, bt: 15, subjectID: "IT3010", species: "normal")
Subject.create!(name: "He quan tri co so du lieu", tc: 3, lt: 30, bt: 10, subjectID: "IT4010", species: "normal")
Subject.create!(name: "He tro giup quyet dinh", tc: 2, lt: 30, bt: 0, subjectID: "IT3110", species: "normal")
Subject.create!(name: "An toan bao mat thong tin", tc: 3, lt: 45, bt: 15, subjectID: "IT3112", species: "normal")
Subject.create!(name: "Project 2", tc: 3, subjectID: "IT4110", species: "project")

puts "Crate currently term"
Term.create!(current: 20142)