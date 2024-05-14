# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

puts "Generating users.."
sofia = User.new(username: "Szcs22", bio: "Test User #1")
sofia.save!
morithi = User.new(username: "morithii", bio: "Test User #2")
morithi.save!
conor = User.new(username: "mcdonald-conor", bio: "Test User #3")
conor.save!
puts "Finished generating users!"

puts "Generating 5 fake collections..."
5.times.do
  collection = Collection.new(
    user_id: rand(1..3)
    title: Faker::Lorem.word
    description: Faker::Lorem.paragraph
  )
  collection.save!
end
puts "Finished generating collections!"

puts "Generating 10 fake mediums..."
10.times.do
  media = Media.new(
    user_id: rand(1..3)
    category: ["Book","Article","Video"].sample
    description: Faker::Lorem.paragraph
    collection_id: rand(1..5)
    author: Faker::Book.author
    title: Faker::Book.title
  )
  media.save!
end
puts "Finished generating mediums!"

puts "Finished!"