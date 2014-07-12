# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_hash = { email: 'user@test.com', password: '123456', password_confirmation: '123456' }

user = User.find_by_email(user_hash[:email]) || User.create(user_hash)

user.timezones.delete_all

zones = [
  { name: 'Me', city: 'Saint-Petersburg', gmt: 4 },
  { name: 'Native town', city: 'Severobaikalsk', gmt: 9 },
  { name: 'Sister', city: 'Abu-Dabi', gmt: 4 },
  { name: 'US Office', city: 'Hartford', gmt: -9 },
  { name: 'UTC+0', city: 'Greenwich', gmt: 0 }
]

zones.each { |zone| user.timezones.create!(zone) }

puts "User## #{user.id} #{user.email} Time zones count = #{user.timezones.size}"