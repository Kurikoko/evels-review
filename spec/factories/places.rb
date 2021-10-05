FactoryBot.define do
  factory :place do
    place_name      { Faker::Lorem.characters(number: 30) }
    carrier         { Faker::Lorem.characters(number: 16) }
    area_id         { Faker::Number.within(range: 2..25) }
    line_kinds_id   { Faker::Number.within(range: 2..4) }
    fee_id          { Faker::Number.within(range: 2..4) }
    backup_line_id  { Faker::Number.within(range: 2..4) }
    wifi_id         { Faker::Number.within(range: 2..4) }

    after(:build) do |place|
      place.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
