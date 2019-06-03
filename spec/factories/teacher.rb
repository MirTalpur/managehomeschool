FactoryBot.define do
  factory :teacher, class: 'Teacher' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    association :user, factory: :user_teacher
  end
end
