FactoryGirl.define do
  factory :club do
      name  "metropole"
      tables_count  "5"
      time_after 1.hour # 300 sec == 5 min
      time_before 15.minutes
      time_last  '23:00'
      time_waiting  20.minutes
      mon_opens '8:00'; mon_closes '23:50'
      tue_opens '8:00'; tue_closes '23:50'
      wed_opens '8:00'; wed_closes '23:50'
      thu_opens '8:00'; thu_closes '23:50'
      fri_opens '8:00'; fri_closes '23:50'
      sat_opens '8:00'; sat_closes '23:50'
      sun_opens '8:00'; sun_closes '23:50'
      description "inka-chaka-zuma"
  end

  factory :table do
    club
  end

  factory :order do
    phone '+375335555555'
    time Time.parse('9:00').tomorrow
    name 'Vasya'
    token '1234567'
    since Time.parse('8:40').tomorrow
    send(:until, Time.parse('11:40').tomorrow)
    factory :updated_order do
      phone '+375291234567'
    end
    #association :table, factory: :table, strategy: :build
  end
end