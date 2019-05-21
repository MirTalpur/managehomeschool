FactoryBot.define do
  factory :teacher, class: 'Teacher' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    user_id { 1 }
  end
end
