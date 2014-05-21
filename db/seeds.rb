# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email

user = User.create(email: 'daniel.weibel@unifr.ch', password: 'changeme')
puts "CREATED USER: email: #{user.email}, password: #{user.password}"

user = User.create(email: 'ulrich.ultes-nitsche@unifr.ch', password: 'changeme')
puts "CREATED USER: email: #{user.email}, password: #{user.password}"

user = User.create(email: 'danielmweibel@gmail.com', password: 'changeme')
puts "CREATED USER: email: #{user.email}, password: #{user.password}"

user = User.create(email: 'danielweibel@gmx.ch', password: 'changeme')
puts "CREATED USER: email: #{user.email}, password: #{user.password}"
