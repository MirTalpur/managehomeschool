FactoryBot.define do
  factory :student, class: 'Student' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    association :user, factory: :user_student
    association :teacher, factory: :teacher
  end
end
