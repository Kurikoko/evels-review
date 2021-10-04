FactoryBot.define do
  factory :user do
    name                  { Faker::Internet.username }
    email                 { Faker::Internet.free_email }
    password              { 'a1' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
  end
end