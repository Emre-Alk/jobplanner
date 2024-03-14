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

job_titles = [
  "Développeur Web Full Stack",
  "Développeur Full Stack Senior",
  "Ingénieur Full Stack",
  "Développeur Full Stack",
  "Lead Développeur Web Full Stack",
  "Expert Full Stack",
  "Développeur Full Stack - Projets Innovants",
  "Architecte Full Stack",
  "Développeur Full Stack - Start-Up Tech",
  "Spécialiste Full Stack",
  "Développeur Full Stack Remote",
  "Développeur Full Stack pour Applications Mobiles",
  "Développeur Full Stack E-commerce",
  "Ingénieur Logiciel Full Stack",
  "Développeur Full Stack - Solutions Cloud",
  "Concepteur Full Stack - Plateformes Digitales",
  "Développeur Full Stack Agile",
  "Développeur Full Stack - Secteur FinTech",
  "Développeur Full Stack - Projets Blockchain",
  "Lead Technique Full Stack",
  "Développeur Full Stack - Intelligence Artificielle",
  "Spécialiste Full Stack - Sécurité Web",
  "Développeur Full Stack - Jeux en Ligne",
  "Consultant Full Stack",
  "Développeur Full Stack - Technologies Émergentes"
]
contract_types = [
  "CDI",
  "CDD - 6 mois",
  "CDD - 12 mois",
  "Contrat freelance",
  "CDD - 24 mois"
]

location = [
  "Lyon",
  "Paris",
  "Nantes",
  "Marseille",
  "Bordeaux",
  "Télétravail"
]

comp = [
"Eiffage",
"Solvay S.A.",
"Blablacar",
"Dassault Systèmes",
"OVHcloud",
"L'Oréal",
"Capgemini",
"Atos",
"Sopra Steria",
"Orange",
"BNP Paribas",
"AXA",
"Ubisoft",
"Publicis Groupe",
"Thales",
"ENGIE",
"SNCF",
"Danone",
"Veolia Environnement",
"Carrefour",
"Accor",
"Airbus",
"Renault",
"TotalEnergies",
"Veepee"
]

stac = [
"rails",
"ruby",
"javascript",
"typescript",
"gitlab",
"github",
"mysql",
"postgresql",
"vscode",
"html5",
"css3",
"tailwindcss"
]

user = User.create!(
  email: 'a@a.com',
  password: '123456',
  token: 'token'
)
puts "#{user.email} - #{user.password} "

i = 10

25.times do
  faker_company = comp.shuffle!.pop
  faker_location = location.sample
  faker_title = job_titles.sample
  faker_date = Faker::Date.between(from: 15.days.ago, to: Date.today)
  faker_contract_type = contract_types.sample
  faker_stack = stac.sample(3)
  p faker_stack

  company = Company.new(name: faker_company)
  p company
  company.save!

  post = Post.new(
    title: faker_title,
    location: faker_location,
    contract_type: faker_contract_type,
    published_on: faker_date,
    url: "https://fr.indeed.com/?r=us&vjk=87aa6baacd5c5711&advn=12366446329411#{i}",
    description: "Une entreprise leader dans les solutions technologiques innovantes, recherche un Développeur Full Stack passionné et expérimenté pour rejoindre notre équipe dynamique. Si vous êtes motivé par les défis techniques et souhaitez contribuer à la création de produits révolutionnaires, ce poste est pour vous.",
    experience_years: rand(0..4).to_i,
    status: [0, 10, 20, 30].sample.to_i,
    updated_at: faker_date
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

  faker_stack.each do |stack_name|
    stack = Stack.find_or_create_by(name: stack_name)
    post_stack = PostStack.new(post: post, stack: stack)
    post_stack.save!
  end

  i += 1
end

puts "seed ok"
