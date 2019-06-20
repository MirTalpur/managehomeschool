FactoryBot.define do
  factory :course do
    time { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    # faker doesn't have school class fake data
    course_name { Faker::Educator.course_name }
    association :schedule, factory: :schedule
    grade_percentage { Faker::Number.between(0, 100) }
    letter_grade { ('A'..'F').to_a.shuffle[0,1].join }
  end
end
