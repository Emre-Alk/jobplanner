# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'
require 'faker'
Post.destroy_all
Company.destroy_all
User.destroy_all
Stack.destroy_all

puts "Destroy all posts, users, stacks, companies"

20.times do
  user_email = Faker::Internet.email(domain: 'gmail.com')
  user_password = Faker::Internet.password(min_length: 3)
  faker_company = Faker::Company.name
  faker_stack = Faker::ProgrammingLanguage.name
  faker_date = Faker::Date.between(from: 15.days.ago, to: Date.today)
  faker_location = Faker::Address.city
  # url_id = rand(10..40)
  # if Rails.env.production?
  #   picture_url = "https://res.cloudinary.com/dnnoyjw9r/image/upload/v1709290819/development/#{id}.jpg"
  # else
  #   picture_url = "https://res.cloudinary.com/dnnoyjw9r/image/upload/v1709219056/development/w86488ztyx76exe4tjvkzy66o9v1.jpg"
  # end
  # picture = URI.open(picture_url)

  user = User.new(
    email: user_email,
    password: user_password,
  )

  user.save!
  puts "#{user.email} - #{user.password} created"

  company = Company.new(
    name: faker_company
  )

  post = Post.new(
    company: company.id,
    location: faker_location,
    date: faker_date,
    stack: faker_stack

  )
  post.save!

end
puts "seed ok"
