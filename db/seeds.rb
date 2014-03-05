# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

clubs = Club.create([
  { 
  	:name => 'Baza',
  	:description => '21+',
  	:tables_count => '3', 
  	:average_time => 1.hour, 
  	:time_last =>'22:50',
    :time_after => '02:00',
    :time_before => '00:10',
  },

  { :name => 'Aplha', :description => 'expensive', :tables_count => '1', 
  	:average_time => 2.hours, :time_last => '22:50',
    :time_after => '02:00',
    :time_before => '00:10',},

  { :name => 'Stopline', :description => 'great drunken party', 
  	:tables_count => '2', :average_time => 5.minutes,
    :time_last => '22:50',
    :time_after => '02:00',
    :time_before => '00:10',},
])
