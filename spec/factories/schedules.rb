FactoryBot.define do
  factory :schedule do
    date { Faker::Date.between('2019-05-05', '2030-05-05') }
    association :student, factory: :student
  end
end
