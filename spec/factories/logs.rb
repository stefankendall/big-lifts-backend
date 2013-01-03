# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :log do
    name "MyString"
    weight 1.5
    sets Random.rand(5)
    reps Random.rand(5)
    notes "MyString"
    date "2012-12-21 11:22:08"
  end
end
