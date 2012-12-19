FactoryGirl.define do
  factory :user do |u|
    u.name { Faker::Name.first_name }
  end
end