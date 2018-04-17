# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 20.times do |i|
#   WorkspaceType.create(workspace_id: i, type_id: rand(2..3), name: 'Office name', number_of_people: rand(10..20), price_hour: '10000', price_day: '100000')
# end

# 20.times do |i|
#   WorkspaceType.create(workspace_id: i+20, type_id: 1, name: 'Office name', number_of_people: rand(10..20), price_week: '500000', price_month: '1500000', price_year: '10000000')
# end

99.times do |i|
   User.create( id: i+2,
                 username: "User_#{i+1}",
                 first_name: "Firstname_#{i+1}",
                 last_name: "Lastname_#{i+1}",
                 email: "abc_#{i+1}@gmail.com",
                 provider: "Facebook",
                 uid: rand(111111..999999)
                )
               end