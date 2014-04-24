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

  {
    :name_ru => "Wi-fi",
    :name_en => "Wi-fi",
    :kind_ru => "Особенность",
    :kind_en => "Feature"
  },

  {
    :name_ru => "Скидка для бородатых",
    :name_en => "Discount for bearded",
    :kind_ru => "Особенность",
    :kind_en => "Feature"
  },

  {
    :name_ru => "Любая",
    :name_en => "Any",
    :kind_ru => "Кухня",
    :kind_en => "Kitchen"
  },
  {
    :name_ru => "Visa",
    :name_en => "Visa",
    :kind_ru => "",
    :kind_en => ""
  },

  {
    :name_ru => "MasterCard",
    :name_en => "MasterCard",
    :kind_ru => "",
    :kind_en => ""
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
    :avatar => '/assets/for_seed/1.jpg', #delete 
    :city => 'Минск',
    :average_price => 100,
    :is_certified => true,
    :metro_station => "Петровщина",
    :site => "google.com",
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
    :is_certified  => false,
    :metro_station => "Каменная горка",
    :site => "google.com",
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
    :is_certified  => true,
    :metro_station => "Площадь Якуба Колоса",
    :site => "google.com",
  },
])

news = News.create!([
  {
    :title       => "Кусок Тургенева как пример новости",
    :description => 'Зовут его Николаем Петровичем Кирсановым. У него в пятнадцати верстах от постоялого дворика хорошее имение в двести душ, или, как он выражается с тех пор, как размежевался с крестьянами и завел "ферму", -- в две тысячи десятин земли. Отец его, боевой генерал 1812 года, полуграмотный, грубый, но не злой русский человек, всю жизнь свою тянул лямку, командовал сперва бригадой, потом дивизией и постоянно жил в провинции, где в силу своего чина играл довольно значительную роль. Николай Петрович родился на юге России, подобно старшему своему брату Павлу, о котором речь впереди, и воспитывался до четырнадцатилетнего возраста дома, окруженный дешевыми гувернерами, развязными, но подобострастными адъютантами и прочими полковыми и штабными личностями.',
    :club        => Club.first,
  },

  {
    :title       => "Почему-то загуглил про сей сериал",
    :description => 'Сериал «Настоящий Детектив» абсолютно заслужено взобрался на вершину IMDB, получив рейтинг 9,5. Два главных актера: Мэттью Макконахи и Вуди Харельсон заслужили любовь зрителей, сыграв роли двух детективов Раста Коула и Мартина Харта. И если последний живет обычной американской жизнью, то Раст Коул — это невероятно интересный персонаж со своей специфической философией. Именно с ней мы хотим вас познакомить.',
    :club        => Club.first,
  },

  {
    :title       => "Конкурс с баблом",
    :description => 'В этом году сообщество бизнес-ангелов и венчурных инвесторов "БАВИН" впервые объявило молодежный конкурс START2GO.MOVE TOGETHER. Молодые бизнесмены борются за крупные денежные призы: призовой фонд составляет 30 тысяч долларов. Жюри уже проделало огромную работу: на первом этапе поступило 182 заявки. Из них 25 проектов отобраны - все они вышли в полуфинал. В финале встретятся и поборются за денежные призы пять стартапов. Четыре проекта выберет жюри конкурса, пятый - читатели портала TUT.BY. Предлагаем вам видеоролики полуфиналистов. Все они надеются на вашу объективность и беспристрастность. На кону - начальный капитал на развитие бизнеса. Напомним, за первое место предусмотрен приз в 15 тысяч долларов, за второе - 10 тысяч, за третье - 5 тысяч.
Голосование закончится 22 апреля в 14.00. При этом при подведении итогов учитываться будут только "лайки". Для того чтобы проголосовать, на видеоплеере нажмите "Нравится" либо "Не нравится" на красной подложке. Читать полностью:  <a href="http://news.tut.by/society/395453.html"> Паливо</a>',
    :club        => Club.first,
  },
])
