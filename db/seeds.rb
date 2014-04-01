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

properties = Property.create([
  {
    :name_ru => "Бар",
    :name_en => "Bar",
    :kind_ru => "Тип",
    :kind_en => "Type"
  },

  {
    :name_ru => "Романтика",
    :name_en => "Romantic",
    :kind_ru => "Атмосфера",
    :kind_en => "Atmosphere"
  },

  {
    :name_ru => "Поминки",
    :name_en => "Wake",
    :kind_ru => "Цель",
    :kind_en => "Goal"
  },

  {
    :name_ru => "Свидание",
    :name_en => "Appointment",
    :kind_ru => "Цель",
    :kind_en => "Goal"
  },

  {
    :name_ru => "Деловая встреча",
    :name_en => "Business meeting",
    :kind_ru => "Цель",
    :kind_en => "Goal"
  },

  {
    :name_ru => "С семьёй",
    :name_en => "With family",
    :kind_ru => "Цель",
    :kind_en => "Goal"
  },

  {
    :name_ru => "Трансляции",
    :name_en => "Broadcast",
    :kind_ru => "Цель",
    :kind_en => "Goal"
  },

  {
    :name_ru => "Отметить",
    :name_en => "Сelebrate",
    :kind_ru => "Цель",
    :kind_en => "Goal"
  },

  {
    :name_ru => "Покушать",
    :name_en => "Eat",
    :kind_ru => "Цель",
    :kind_en => "Goal"
  },

  {
    :name_ru => "Потусоваться",
    :name_en => "Hang",
    :kind_ru => "Цель",
    :kind_en => "Goal"
  },

  {
    :name_ru => "Бухнуть по ярому",
    :name_en => "Drink",
    :kind_ru => "Цель",
    :kind_en => "Goal"
  },
])

clubs = Club.create!([
  { 
  	:name => 'Baza',
  	:description => '21+',
  	:tables_count => '3',
  	:time_last =>'22:50',
    :time_after => 3600,
    :time_before => 3600,
    :adress => "Minsk, Lenina 23",
    :phone => "+375336660055",
    :user_id => owners.select{|o| o[:owner_clubs] == true}.first.id,
    :properties => Property.all,
    :avatar => '/assets/for_seed/1.jpg'
  },

  { 
    :name => 'Aplha', :description => 'expensive', 
    :tables_count => '1',
    :time_last => '22:50',
    :time_after => 3600,
    :time_before => 3600,
    :adress => "Minsk, Lenina 89",
    :phone => "+375336662255",
    :user_id => owners.select{|o| o[:owner_clubs] == true}.first.id,
    :properties => Property.all,
    :avatar => '/assets/for_seed/2.jpg'
  },

  { 
    :name => 'Stopline', 
    :description => 'great drunken party', 
  	:tables_count => '2',
    :time_last => '22:50',
    :time_after => 3600,
    :time_before => 3600,
    :adress => "Minsk, Lesnay 23",
    :phone => "+375336661155",
    :user_id => owners.select{|o| o[:owner_clubs] == true}.first.id,
    :properties => Property.all,
    :avatar => '/assets/for_seed/3.jpg'
  },
])

