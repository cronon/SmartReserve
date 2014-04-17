#encoding: utf-8 
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
    :name => "Аникеенко",
    :locale => "ru"
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
    :address => "Minsk, Lenina 23",
    :phone => "+375336660055",
    :user_id => owners.select{|o| o[:owner_clubs] == true}.first.id,
    :properties => Property.all,
    :avatar => '/assets/for_seed/1.jpg',
    :city => 'Минск',
    :average_price => 100,
    :is_certified => true
  },

  { 
    :name => 'Aplha', :description => 'expensive', 
    :tables_count => '1',
    :time_last => '22:50',
    :time_after => 3600,
    :time_before => 3600,
    :address => "Minsk, Lenina 89",
    :phone => "+375336662255",
    :user_id => owners.select{|o| o[:owner_clubs] == true}.first.id,
    :properties => Property.all,
    :avatar => '/assets/for_seed/2.jpg',
    :city => 'Минск',
    :average_price => 100,
    :is_certified => false
  },

  { 
    :name => 'Stopline', 
    :description => 'great drunken party', 
  	:tables_count => '2',
    :time_last => '22:50',
    :time_after => 3600,
    :time_before => 3600,
    :address => "Minsk, Lesnay 23",
    :phone => "+375336661155",
    :user_id => owners.select{|o| o[:owner_clubs] == true}.first.id,
    :properties => Property.all,
    :avatar => '/assets/for_seed/3.jpg',
    :city => 'Минск',
    :average_price => 100,
    :is_certified => true
  },
])

news = News.create!([
  {
    :title       => "Кусок Тургенева как пример новости",
    :description => 'Зовут его Николаем Петровичем Кирсановым. У него в пятнадцати верстах от постоялого дворика хорошее имение в двести душ, или, как он выражается с тех пор, как размежевался с крестьянами и завел "ферму", -- в две тысячи десятин земли. Отец его, боевой генерал 1812 года, полуграмотный, грубый, но не злой русский человек, всю жизнь свою тянул лямку, командовал сперва бригадой, потом дивизией и постоянно жил в провинции, где в силу своего чина играл довольно значительную роль. Николай Петрович родился на юге России, подобно старшему своему брату Павлу, о котором речь впереди, и воспитывался до четырнадцатилетнего возраста дома, окруженный дешевыми гувернерами, развязными, но подобострастными адъютантами и прочими полковыми и штабными личностями.',
    :club => Club.first,
  }
])