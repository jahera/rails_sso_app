# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@user1 = User.create!(email: "test@test.com", password:'12345678', company_id: 1, consumer_service_url: "http://localhost:3001/")

payload = {email: @user1.email, company_id: @user1.company_id}
token = JWT.encode(payload, Rails.application.secrets.secret_key_base)
puts "==========   #{token}"
@user1.auth_token = token
@user1.save

@user2 = User.create!(email: "test123@test.com", password:'12345678', company_id: 2, consumer_service_url: "http://localhost:3002/")
payload = {email: @user2.email, company_id: @user2.company_id}
token = JWT.encode(payload, Rails.application.secrets.secret_key_base)
puts "==========   #{token}"
@user2.auth_token = token
@user2.save

