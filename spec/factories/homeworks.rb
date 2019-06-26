FactoryBot.define do
  factory :homework do
    title { Faker::Book.title }
    description { Faker::Quotes::Shakespeare.as_you_like_it }
    due_date { Faker::Date.forward(0) }
    graded { Faker::Boolean.boolean }
    grade_percentage { Faker::Number.between(0, 100) }
    letter_grade { ('A'..'F').to_a.shuffle[0,1].join }
    file { Faker::File.file_name }
    association :student, factory: :student
    association :course, factory: :course
  end
end
