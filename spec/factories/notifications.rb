# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    phone "MyString"
    is_phone false
    email "MyString"
    is_email false
    references "MyString"
    Club "MyString"
  end
end
