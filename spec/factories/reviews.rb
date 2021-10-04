FactoryBot.define do
  factory :review do
    download  {Faker::Number.within(range: 0.01..3000)}
    upload    {Faker::Number.within(range: 0.01..3000)}
    comment   {Faker::Lorem.characters}

    after(:build) do |review|
      review.image.attach(io: File.open('public/images/test_image.png'), filename:'test_image.png')
    end
    association :user
    association :place
    
  end
end
