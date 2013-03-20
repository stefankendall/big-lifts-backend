FactoryGirl.define do
  factory :user do |u|
    u.username { Faker::Internet.user_name }
    u.password { Faker::Internet.user_name }
  end
end