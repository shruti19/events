# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Truncating old records.."
ActiveRecord::Base.connection.execute("TRUNCATE TABLE users")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE events")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE attendees")

User.create!(:first_name => "Jack",
  :last_name => "Eskafyan", 
  :gender => "male",
  :email => "jack@yopmail.com",
  :password => "wolfishere",
  :password_confirmation => "wolfishere")

User.create!(:first_name => "Jill",
  :last_name => "Gascca", 
  :gender => "female",
  :email => "jill@yopmail.com",
  :password => "skylights",
  :password_confirmation => "skylights")

########## Add users #########
records = []
for i in 2..100
  records << {:first_name => "user#{i}_fn",
    :last_name => "user#{i}_ln",
    :gender => ["male", "female"].sample,
    :email => "user#{i}@yopmail.com",
    :password => "test1234",
    :password_confirmation => "test1234"}
end
puts "Creating users..."
User.create!(records)
puts "Users created."
puts " "
########## Add events #########

## Total 20 events created with 15 active events
events = []
for i in 1..15
  events << {:name => "Event #{i}",
    :description => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
    :due_date => Date.today + i.day,
    :fee => [nil, 500, 1000, 1500, 2000].sample,
    :discount => [nil, 5].sample}
end

#### Create 5 past events
for i in 16..20
  events << {:name => "Event #{i}",
    :description => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
    :due_date => Date.today - i.day,
    :fee => [nil, 500, 1000, 1500, 2000].sample,
    :discount => [nil, 5].sample}
end
puts "Creating events..."
Event.create!(events)
puts "Events created."
puts " "
########## Add participants #########

puts "Creating participants..."
## Participant count 100 for random 9 events (prime numbers selected)
random_10 = Event.find(1,2,3,5,7,11,13,17,19)
User.all.each do |user|
  user.events << random_10
end

## Participant count 92, 83, 74 for first events 4,6,8 respectively
User.first(92).each do |user|
  user.events << Event.find(4)
end

User.first(83).each do |user|
  user.events << Event.find(6)
end

User.first(74).each do |user|
  user.events << Event.find(8)
end

User.last(8).each do |user|
  user.events << Event.find(9,10,12,14,15,16)
end
puts "Participants created."
puts " "
## Each of user 1 through 92 is attending 12 events
## Last 8 users attend 6 events each
## Events 18 and 20 have 0 participants


puts "************************************************************************************"
puts "Done creating records. You may now login with credentials given below or signup new."
puts "************************************************************************************"
puts " "

puts "Male user login:"
puts "================================="
puts "email: jack@yopmail.com"
puts "password: wolfishere"
puts "================================="
puts " "

puts "Female user login: (Avail extra discounts on event fees) "
puts "================================="
puts "email: jill@yopmail.com"
puts "password: skylights"
puts "================================="