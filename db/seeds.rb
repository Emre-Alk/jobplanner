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
PostStack.destroy_all
Post.destroy_all
Company.destroy_all
User.destroy_all
Stack.destroy_all

puts "Destroy all posts, users, stacks, companies"

user = User.create!(
  email: 'a@a.com',
  password: '123456',
  token: 'token'
)
puts "#{user.email} - #{user.password} "

50.times do
  faker_company = Faker::Company.name
  faker_location = Faker::Address.city
  faker_title = Faker::Job.title
  logo = "https://media.licdn.com/dms/image/C560BAQEbIYAkAURcYw/company-logo_100_100/0/1650566107463/canonical_logo?e=1717632000&v=beta&t=Iw7KBd9gVHxKGYMsE5DFmcCSzazrARLeeXPJomYeqmA"
  faker_date = Faker::Date.between(from: 15.days.ago, to: Date.today)
  faker_contract_type = Faker::Job.employment_type
  faker_stack = Faker::ProgrammingLanguage.name

  company = Company.new(name: faker_company, logo_url: logo)
  p company
  company.save!

  post = Post.new(
    title: faker_title,
    location: faker_location,
    contract_type: faker_contract_type,
    published_on: faker_date,
    url: "https://www.linkedin.com/jobs/search/?currentJobId=2948680713&keywords=web%20developer&origin=BLENDED_SEARCH_RESULT_NAVIGATION_JOB_CARD",
    description: "lorem ipsum",
    experience_years: rand(0..4).to_i,
    status: [0, 10, 30].sample.to_i,
    created_at: faker_date
  )
  post.user = user
  post.company = company
  post.save!

  stack = Stack.new(
    name: faker_stack
  )
  stack.save!

  post_stack = PostStack.new
  post_stack.post = post
  post_stack.stack = stack

  post_stack.save!

end

puts "seed ok"
