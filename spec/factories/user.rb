FactoryBot.define do
  factory :default_user, class: 'User' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :user_teacher, class: 'User' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    user_type { 'teacher' }
  end
  
  factory :user_student, class: 'User' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    user_type { 'student' }
  end
end
