FactoryGirl.define do
  factory :user do |u|
    u.username { Faker::Internet.user_name }
    u.password 'test'
  end
end