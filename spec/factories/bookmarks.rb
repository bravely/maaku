# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bookmark do
    folder
    name 'Test bookmark'
    url 'http://www.example.com/#testjsspot'
  end
end
