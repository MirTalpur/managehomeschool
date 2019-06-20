FactoryBot.define do
  factory :attendance do
    date { Faker::Date.between('2019-05-05', '2030-05-05') }
    attending { Faker::Boolean.boolean }
    reason { Faker::String.random }
    association :student, factory: :student
    files { Faker::File.file_name }
  end
end
