# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Event.destroy_all

User.create!(:first_name => "Leonardo",
	:last_name => "Decaprio", 
	:email => "leonardo@yopmail.com",
	:password => "wolfishere",
	:password_confirmation => "wolfishere")

records = []
for i in 1..5
  records << {:first_name => "user#{i}_fn"
  	:last_name => "user#{i}_ln",
  	:email => "user#{i}@yopmail.com",
  	:password => "test1234",
  	:password_confirmation => "test1234"}
end

User.create!(records)

events = []
for i in 1..15
  events << {:name => "Event #{i}"
  	:description => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
  	:due_date => Date.today + i.day}
end

#### Create past events
for i in 16..20
  events << {:name => "Event #{i}"
  	:description => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
  	:due_date => Date.today - i.day}
end

Event.create!(events)