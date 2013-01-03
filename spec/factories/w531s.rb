# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :w531 do
    cycle Random.rand(100)
    week 1+Random.rand(4)
    expected_reps 3+Random.rand(7)
  end
end
