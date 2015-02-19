require 'faker'

#Create users

10.times do
  user = User.new(
    username: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password: "test123",
    password_confirmation: "test123"
  )
  user.save!
end

users = User.all

options = ["private", "viewable", "open"]

#Create Lists
20.times do
  List.create!(
    title: Faker::Lorem.word,
    permissions: options[rand(3)],
    user: users.sample
  )
end

lists = List.all

100.times do
  Item.create!(
    description: Faker::Lorem.sentence,
    list: lists.sample
  )
end

puts "Seeds finished!"
puts "#{users.count} users created."
puts "#{lists.count} lists created."
puts "#{Item.all.count} items created."
