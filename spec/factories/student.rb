FactoryBot.define do
  factory :student, class: 'Student' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
