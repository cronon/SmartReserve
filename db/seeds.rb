# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

owners = User.create([
  {
    :email => "anikeenko_90@mail.ru",
    :phone => "+375336057093",
    :owner_clubs => true,
    #:password => "$2a$10$2q7HC3M1.ho928wlkGx5VeiCctzcoXTLjujbCSLciZ.7D7BniuaPm",
    :password => "12345678",
    :name => "Аникеенко"
    },
  ])

clubs = Club.create([
  { 
  	:name => 'Baza',
  	:description => '21+',
  	:tables_count => '3',
  	:time_last =>'22:50',
    :time_after => '02:00',
    :time_before => '00:10',
    :adress => "Minsk, Lenina 23",
    :phone => "+375336660055",
    :owner_id => owners.select{|o| o[:owner_clubs] == true}.first.id,
  },

  { 
    :name => 'Aplha', :description => 'expensive', 
    :tables_count => '1',
    :time_last => '22:50',
    :time_after => '02:00',
    :time_before => '00:10',
    :adress => "Minsk, Lenina 89",
    :phone => "+375336662255",
    :owner_id => owners.select{|o| o[:owner_clubs] == true}.first.id,
  },

  { 
    :name => 'Stopline', 
    :description => 'great drunken party', 
  	:tables_count => '2',
    :time_last => '22:50',
    :time_after => '02:00',
    :time_before => '00:10',
    :adress => "Minsk, Lesnay 23",
    :phone => "+375336661155",
    :owner_id => owners.select{|o| o[:owner_clubs] == true}.first.id,
  },
])

